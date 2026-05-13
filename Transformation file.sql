/*==============================================================================
  PROCEDURE: silver.load_silver
  DESCRIPTION: Loads and transforms data from BRONZE to SILVER layer
               Includes data cleansing, standardisation, deduplication,
               and SCD Type 2 logic for product dimension.

  FEATURES:
  - Full refresh (TRUNCATE + INSERT)
  - TRY/CATCH error handling
  - Execution time tracking (duration)
  - Structured ETL logging

  AUTHOR: Teddy Baloyi
  VERSION: 1.1
==============================================================================*/

CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @start_time DATETIME = GETDATE();
    DECLARE @end_time DATETIME;
    DECLARE @duration_seconds INT;

    BEGIN TRY
        BEGIN TRAN;

        PRINT '=================================================';
        PRINT ' SILVER LAYER LOAD STARTED';
        PRINT ' START TIME: ' + CAST(@start_time AS NVARCHAR);
        PRINT '=================================================';

        --------------------------------------------------------------------------------
        -- 1. CUSTOMER DIMENSION
        --------------------------------------------------------------------------------
        PRINT 'Loading: silver.crm_cst_info';
        TRUNCATE TABLE silver.crm_cst_info;

        INSERT INTO silver.crm_cst_info (
            cst_id, cst_key, cst_firstname, cst_lastname,
            cst_material_status, cst_gndr, cst_create_date
        )
        SELECT
            cst_id,
            cst_key,
            TRIM(cst_firstname),
            TRIM(cst_lastname),

            CASE 
                WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
                WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
                ELSE 'n/a'
            END,

            CASE 
                WHEN UPPER(TRIM(cst_gndr)) IN ('F','FEMALE') THEN 'Female'
                WHEN UPPER(TRIM(cst_gndr)) IN ('M','MALE') THEN 'Male'
                ELSE 'n/a'
            END,

            cst_create_date
        FROM (
            SELECT *,
                   ROW_NUMBER() OVER (
                       PARTITION BY cst_id
                       ORDER BY cst_create_date DESC
                   ) AS rn
            FROM bronze.crm_cst_info
            WHERE cst_id IS NOT NULL
        ) t
        WHERE rn = 1;

        --------------------------------------------------------------------------------
        -- 2. PRODUCT DIMENSION
        --------------------------------------------------------------------------------
        PRINT 'Loading: silver.crm_prd_info';
        TRUNCATE TABLE silver.crm_prd_info;

        INSERT INTO silver.crm_prd_info (
            prd_id, cat_id, prd_key, prd_nm,
            prd_cost, prd_line, prd_start_dt, prd_end_dt
        )
        SELECT
            prd_id,
            REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_'),
            SUBSTRING(prd_key, 7, LEN(prd_key)),
            prd_nm,
            ISNULL(prd_cost, 0),

            CASE 
                WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
                WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
                WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
                WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
                ELSE 'n/a'
            END,

            CAST(prd_start_dt AS DATE),

            CAST(
                DATEADD(DAY, -1,
                    LEAD(prd_start_dt) OVER (
                        PARTITION BY prd_key
                        ORDER BY prd_start_dt
                    )
                ) AS DATE
            )
        FROM bronze.crm_prd_info;

        --------------------------------------------------------------------------------
        -- 3. SALES FACT TABLE
        --------------------------------------------------------------------------------
        PRINT 'Loading: silver.crm_sales_details';
        TRUNCATE TABLE silver.crm_sales_details;

        INSERT INTO silver.crm_sales_details (
            sls_ord_num, sls_prd_key, sls_cst_id,
            sls_order_dt, sls_shp_dt, sls_due_dt,
            sls_sales, sls_quantity, sls_price
        )
        SELECT
            sls_ord_num,
            sls_prd_key,
            sls_cst_id,

            CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) <> 8 THEN NULL
                 ELSE CONVERT(DATE, CAST(sls_order_dt AS NVARCHAR(8)), 112)
            END,

            CASE WHEN sls_shp_dt = 0 OR LEN(sls_shp_dt) <> 8 THEN NULL
                 ELSE CONVERT(DATE, CAST(sls_shp_dt AS NVARCHAR(8)), 112)
            END,

            CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) <> 8 THEN NULL
                 ELSE CONVERT(DATE, CAST(sls_due_dt AS NVARCHAR(8)), 112)
            END,

            CASE 
                WHEN sls_sales IS NULL 
                     OR sls_sales <= 0 
                     OR sls_sales != sls_quantity * ABS(sls_price)
                THEN sls_quantity * ABS(sls_price)
                ELSE sls_sales
            END,

            sls_quantity,

            CASE 
                WHEN sls_price IS NULL OR sls_price <= 0 
                THEN sls_sales / NULLIF(sls_quantity, 0)
                ELSE sls_price
            END
        FROM bronze.crm_sales_details;

        --------------------------------------------------------------------------------
        -- 4. CUSTOMER DEMOGRAPHICS
        --------------------------------------------------------------------------------
        PRINT 'Loading: silver.erp_cust_az12';
        TRUNCATE TABLE silver.erp_cust_az12;

        INSERT INTO silver.erp_cust_az12 (cid, bdate, gen)
        SELECT
            CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
                 ELSE cid
            END,
            CASE WHEN bdate > GETDATE() THEN NULL ELSE bdate END,
            CASE 
                WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
                WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
                ELSE 'n/a'
            END
        FROM bronze.erp_cust_az12;

        --------------------------------------------------------------------------------
        -- 5. LOCATION DATA
        --------------------------------------------------------------------------------
        PRINT 'Loading: silver.erp_loc_a101';
        TRUNCATE TABLE silver.erp_loc_a101;

        INSERT INTO silver.erp_loc_a101 (cid, cntry)
        SELECT
            REPLACE(cid, '-', ''),
            CASE 
                WHEN TRIM(cntry) = 'DE' THEN 'Germany'
                WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
                WHEN TRIM(cntry) IS NULL OR TRIM(cntry) = '' THEN 'n/a'
                ELSE TRIM(cntry)
            END
        FROM bronze.erp_loc_a101;

        --------------------------------------------------------------------------------
        -- 6. REFERENCE DATA
        --------------------------------------------------------------------------------
        PRINT 'Loading: silver.erp_px_cust_g1v2';
        TRUNCATE TABLE silver.erp_px_cust_g1v2;

        INSERT INTO silver.erp_px_cust_g1v2 (id, cat, subcat, maintanace)
        SELECT id, cat, subcat, maintanace
        FROM bronze.erp_px_cust_g1v2;

        --------------------------------------------------------------------------------
        -- END PROCESS
        --------------------------------------------------------------------------------
        COMMIT;

        SET @end_time = GETDATE();
        SET @duration_seconds = DATEDIFF(SECOND, @start_time, @end_time);

        PRINT '=================================================';
        PRINT ' SILVER LAYER LOAD COMPLETED SUCCESSFULLY';
        PRINT ' END TIME: ' + CAST(@end_time AS NVARCHAR);
        PRINT ' DURATION (SECONDS): ' + CAST(@duration_seconds AS NVARCHAR);
        PRINT '=================================================';

    END TRY
    BEGIN CATCH
        ROLLBACK;

        SET @end_time = GETDATE();
        SET @duration_seconds = DATEDIFF(SECOND, @start_time, @end_time);

        PRINT '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!';
        PRINT ' SILVER LAYER LOAD FAILED';
        PRINT ERROR_MESSAGE();
        PRINT ' FAILURE DURATION (SECONDS): ' + CAST(@duration_seconds AS NVARCHAR);
        PRINT '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!';
    END CATCH
END;