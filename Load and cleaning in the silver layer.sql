----Check for Nulls and duplicates in Primary keys
----expectations: No result

SELECT prd_key,COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_key
HAVING COUNT(*) > 1 OR prd_key IS NULL

SELECT*
FROM bronze.crm_prd_info

-----CHECK THE UNWANTED SPACES
---- EXPECTATIONS: NO RESULTS
 
 SELECT cst_firstname
 FROM silver.crm_cst_info
 WHERE cst_firstname != TRIM(cst_firstname)

 SELECT cst_lastname
 FROM silver.crm_cst_info
 WHERE cst_lastname != TRIM(cst_lastname)

 SELECT cst_firstname
 FROM silver.crm_cst_info
 WHERE cst_firstname != TRIM(cst_firstname)

 SELECT cst_material_status
 FROM silver.crm_cst_info
 WHERE cst_material_status != TRIM(cst_material_status)


 SELECT cst_gndr
 FROM silver.crm_cst_info
 WHERE cst_gndr != TRIM(cst_gndr)

 ----Data standadisation and consistancy

 SELECT DISTINCT prd_line
 FROM bronze.crm_prd_info

 SELECT 
    COUNT(*) AS null_count
FROM bronze.crm_prd_info
WHERE prd_line IS NULL;

 SELECT DISTINCT prd_id
 FROM bronze.crm_cst_info
 

 SELECT *
 FROM bronze.erp_px_cust_g1v2