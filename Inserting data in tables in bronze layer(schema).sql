BULK INSERT bronze.crm_cst_info
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);

BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);

BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);

BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);

BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);


BULK INSERT bronze.erp_px_cust_g1v2
FROM 'C:\Users\user\Documents\Dataests\Data_warehouse_dataset\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',' ,
    TABLOCK
);
 
 SELECT *
 FROM bronze.crm_cst_info