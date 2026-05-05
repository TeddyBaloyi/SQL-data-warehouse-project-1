/*
===========================================================
 Project: Data Warehouse - Bronze Layer Metadata Fix
 Author: Teddy Baloyi
 Description: Add + fix metadata for all Bronze tables
===========================================================
*/

-- =========================================================
-- CRM TABLES
-- =========================================================

-- CUSTOMER
IF COL_LENGTH('bronze.crm_cst_info', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.crm_cst_info
    ADD load_date DATETIME2;
END;

IF COL_LENGTH('bronze.crm_cst_info', 'source_system') IS NULL
BEGIN
    ALTER TABLE bronze.crm_cst_info
    ADD source_system NVARCHAR(50);
END;

UPDATE bronze.crm_cst_info
SET 
    load_date = ISNULL(load_date, GETDATE()),
    source_system = ISNULL(source_system, 'CRM');


-- PRODUCT
IF COL_LENGTH('bronze.crm_prd_info', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.crm_prd_info
    ADD load_date DATETIME2;
END;

IF COL_LENGTH('bronze.crm_prd_info', 'source_system') IS NULL
BEGIN
    ALTER TABLE bronze.crm_prd_info
    ADD source_system NVARCHAR(50);
END;

UPDATE bronze.crm_prd_info
SET 
    load_date = ISNULL(load_date, GETDATE()),
    source_system = ISNULL(source_system, 'CRM');


-- SALES
IF COL_LENGTH('bronze.crm_sales_details', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.crm_sales_details
    ADD load_date DATETIME2;
END;

IF COL_LENGTH('bronze.crm_sales_details', 'source_system') IS NULL
BEGIN
    ALTER TABLE bronze.crm_sales_details
    ADD source_system NVARCHAR(50);
END;

UPDATE bronze.crm_sales_details
SET 
    load_date = ISNULL(load_date, GETDATE()),
    source_system = ISNULL(source_system, 'CRM');


-- =========================================================
-- ERP TABLES
-- =========================================================

-- LOCATION
IF COL_LENGTH('bronze.erp_loc_a101', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.erp_loc_a101
    ADD load_date DATETIME2;
END;

IF COL_LENGTH('bronze.erp_loc_a101', 'source_system') IS NULL
BEGIN
    ALTER TABLE bronze.erp_loc_a101
    ADD source_system NVARCHAR(50);
END;

UPDATE bronze.erp_loc_a101
SET 
    load_date = ISNULL(load_date, GETDATE()),
    source_system = ISNULL(source_system, 'ERP');


-- CUSTOMER DEMOGRAPHICS
IF COL_LENGTH('bronze.erp_cust_az12', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.erp_cust_az12
    ADD load_date DATETIME2;
END;

IF COL_LENGTH('bronze.erp_cust_az12', 'source_system') IS NULL
BEGIN
    ALTER TABLE bronze.erp_cust_az12
    ADD source_system NVARCHAR(50);
END;

UPDATE bronze.erp_cust_az12
SET 
    load_date = ISNULL(load_date, GETDATE()),
    source_system = ISNULL(source_system, 'ERP');


-- PRODUCT CATEGORY MAPPING
IF COL_LENGTH('bronze.erp_px_cust_g1v2', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.erp_px_cust_g1v2
    ADD load_date DATETIME2;
END;

IF COL_LENGTH('bronze.erp_px_cust_g1v2', 'source_system') IS NULL
BEGIN
    ALTER TABLE bronze.erp_px_cust_g1v2
    ADD source_system NVARCHAR(50);
END;

UPDATE bronze.erp_px_cust_g1v2
SET 
    load_date = ISNULL(load_date, GETDATE()),
    source_system = ISNULL(source_system, 'ERP');


