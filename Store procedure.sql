/*
===========================================
 Project: Data Warehouse - Bronze. Load store procedure
 Author: Teddy Baloyi
 Date: 2026-05-04
 Description: Bulk load CRM and ERP source data into bronze (Load store procedure)
===========================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    PRINT 'Starting Bronze Layer Load...';

    -- =========================================
    -- CRM TABLES
    -- =========================================

    PRINT 'Loading CRM Customer Info...';
    TRUNCATE TABLE bronze.crm_cst_info;

    BULK INSERT bronze.crm_cst_info
    FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    PRINT 'Loading CRM Product Info...';
    TRUNCATE TABLE bronze.crm_prd_info;

    BULK INSERT bronze.crm_prd_info
    FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    PRINT 'Loading CRM Sales Details...';
    TRUNCATE TABLE bronze.crm_sales_details;

    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    -- =========================================
    -- ERP TABLES
    -- =========================================

    PRINT 'Loading ERP Customer Data...';
    TRUNCATE TABLE bronze.erp_cust_az12;

    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    PRINT 'Loading ERP Location Data...';
    TRUNCATE TABLE bronze.erp_loc_a101;

    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    PRINT 'Loading ERP Product Category Data...';
    TRUNCATE TABLE bronze.erp_px_cust_g1v2;

    BULK INSERT bronze.erp_px_cust_g1v2
    FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    PRINT 'Bronze Layer Load Completed Successfully!';
END;


EXEC bronze.load_bronze