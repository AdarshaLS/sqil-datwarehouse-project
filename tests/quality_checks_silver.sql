/* 
==================================================================================
Quality Checks
==================================================================================
Script Purpose:
	This script performs various quality checks for data consistency, accuracy, and standardization across the ‘silver’ schema. It includes checks ofr:
	-Null or duplicate primary keys.
	-Unwanted spaces in string fields.
	-Data Standardization and consistency.
	-Invalid sate ranges and orders.
	-Data consistency between related fields.

Usage Notes:
	-Run these checks after data loading Silver Layer.
	-Investigate and resolve any discrepancies found during the checks.
==================================================================================
*/


--24. Load Script01
--Check For Nulls or duplicates in Primary Key
--Expectation: No Result

SELECT
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id is NULL;


--Data filtering removing invalid
SELECT *
FROM(
SELECT 
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info)
t WHERE flag_last=1;



--Check for unwanted Spaces
--Expactation: No Results
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname!=TRIM(cst_firstname);

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname!=TRIM(cst_lastname);

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr!=TRIM(cst_gndr);


--Check For Nulls or duplicates in Primary Key
--Expectation: No Result

SELECT
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id is NULL;


--Data filtering removing invalid
SELECT *
FROM(
SELECT 
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info)
t WHERE flag_last=1;


-- Quality of silver 

--Check for unwanted Spaces
--Expactation: No Results
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname!=TRIM(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname!=TRIM(cst_lastname);

SELECT cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr!=TRIM(cst_gndr);

--Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;


--Check Data Consistency: Between Sales, Quantity and price 
-->> Sales = Quantity*Price
-->> Values must not be NULL, Zero or negative
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM 
silver.crm_sales_details
WHERE sls_sales ! = sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0;
