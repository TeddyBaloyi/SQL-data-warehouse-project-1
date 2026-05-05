/*
===========================================================
 Project: Data Warehouse - Bronze Layer Metadata Update
 Author: Teddy Baloyi
 Description: Add metadata columns to all Bronze tables safely
===========================================================
*/

-- =========================================================
-- CRM TABLES
-- =========================================================

-- CUSTOMER TABLE
IF COL_LENGTH('bronze.crm_cst_info', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.crm_cst_info
    ADD 
        load_date DATETIME2 CONSTRAINT df_crm_cst_info_load_date DEFAULT GETDATE(),
        source_system NVARCHAR(50) CONSTRAINT df_crm_cst_info_source DEFAULT 'CRM';
END;


-- PRODUCT TABLE
IF COL_LENGTH('bronze.crm_prd_info', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.crm_prd_info
    ADD 
        load_date DATETIME2 CONSTRAINT df_crm_prd_info_load_date DEFAULT GETDATE(),
        source_system NVARCHAR(50) CONSTRAINT df_crm_prd_info_source DEFAULT 'CRM';
END;


-- SALES TABLE
IF COL_LENGTH('bronze.crm_sales_details', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.crm_sales_details
    ADD 
        load_date DATETIME2 CONSTRAINT df_crm_sales_details_load_date DEFAULT GETDATE(),
        source_system NVARCHAR(50) CONSTRAINT df_crm_sales_details_source DEFAULT 'CRM';
END;


-- =========================================================
-- ERP TABLES
-- =========================================================

-- LOCATION TABLE
IF COL_LENGTH('bronze.erp_loc_a101', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.erp_loc_a101
    ADD 
        load_date DATETIME2 CONSTRAINT df_erp_loc_a101_load_date DEFAULT GETDATE(),
        source_system NVARCHAR(50) CONSTRAINT df_erp_loc_a101_source DEFAULT 'ERP';
END;


-- CUSTOMER DEMOGRAPHICS
IF COL_LENGTH('bronze.erp_cust_az12', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.erp_cust_az12
    ADD 
        load_date DATETIME2 CONSTRAINT df_erp_cust_az12_load_date DEFAULT GETDATE(),
        source_system NVARCHAR(50) CONSTRAINT df_erp_cust_az12_source DEFAULT 'ERP';
END;


-- PRODUCT CATEGORY MAPPING
IF COL_LENGTH('bronze.erp_px_cust_g1v2', 'load_date') IS NULL
BEGIN
    ALTER TABLE bronze.erp_px_cust_g1v2
    ADD 
        load_date DATETIME2 CONSTRAINT df_erp_px_cust_g1v2_load_date DEFAULT GETDATE(),
        source_system NVARCHAR(50) CONSTRAINT df_erp_px_cust_g1v2_source DEFAULT 'ERP';
END;




UPDATE bronze.crm_cst_info
SET 
    load_date = ISNULL(load_date, GETDATE()),
    source_system = ISNULL(source_system, 'CRM');



   