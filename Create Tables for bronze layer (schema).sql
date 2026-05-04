/*
===========================================================
 Project: Data Warehouse - Bronze Layer (schema)
 Author: Teddy Baloyi
 Description: Recreate all bronze layer (schema) tables (CRM + ERP)
===========================================================
*/

-- =========================================================
-- CRM TABLES
-- =========================================================

-- CUSTOMER TABLE

IF OBJECT_ID('bronze.crm_cst_info' , 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_cst_info;
END;

CREATE TABLE bronze.crm_cst_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

-- PRODUCT TABLE

IF OBJECT_ID('bronze.crm_prd_info' , 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_prd_info;
END;

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);

-- SALES TABLE

IF OBJECT_ID('bronze.crm_sales_details' , 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_sales_details;
END;

CREATE TABLE bronze.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cst_id INT,
    sls_order_dt INT,
    sls_shp_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- =========================================================
-- ERP TABLES
-- =========================================================

-- LOCATION TABLE

IF OBJECT_ID('bronze.erp_loc_a101' , 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.erp_loc_a101;
END;

CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);

-- CUSTOMER DEMOGRAPHICS

IF OBJECT_ID('bronze.erp_cust_az12' , 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.erp_cust_az12;
END;

CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);

-- PRODUCT CATEGORY MAPPING

IF OBJECT_ID('bronze.erp_px_cust_g1v2' , 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.erp_px_cust_g1v2;
END;

CREATE TABLE bronze.erp_px_cust_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintanace NVARCHAR(50)
);
