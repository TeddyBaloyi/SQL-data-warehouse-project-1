/*
===========================================
 Project: Data Warehouse - Bronze Layer Load
 Author: Teddy Baloyi
 Date: 2026-05-04
 Description: Bulk load CRM and ERP source data into bronze schema
===========================================
*/

-- =========================================
-- CRM TABLES
-- =========================================

PRINT 'Loading CRM Customer Info...';

TRUNCATE TABLE bronze.crm_cst_info

BULK INSERT bronze.crm_cst_info
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);
TRUNCATE TABLE bronze.crm_prd_info

BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);
TRUNCATE TABLE bronze.crm_sales_details

BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);

-- =========================================
-- ERP TABLES
-- =========================================

PRINT 'Loading ERP Customer Data...';

TRUNCATE TABLE bronze.erp_cust_az12

BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
);

TRUNCATE TABLE bronze.erp_loc_a101

BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);

TRUNCATE TABLE bronze.erp_px_cust_g1v2

BULK INSERT bronze.erp_px_cust_g1v2
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);
 