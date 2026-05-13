 CREATE OR ALTER VIEW gold.dim_product AS
 SELECT 
    ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt , pn.prd_key) AS product_key,
    pn.prd_id AS Product_id,
    pn.prd_key AS Product_number,
    pn.prd_nm AS Product_name,
    pn.cat_id AS Category_id,
    pc.cat AS Category,
    pc.subcat AS Subcategory,
    pc.maintanace,
    pn.prd_cost AS cost,
    pn.prd_line AS Product_line,
    pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cust_g1v2 pc
ON    pn.cat_id = pc.id
WHERE prd_end_dt IS NULL           ----------- Filter the historical data


