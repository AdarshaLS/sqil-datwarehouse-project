/*
=============================================================================================
Stored Procedure: Load Silver Layer(Bronze -> Silver)
=============================================================================================
Script Purpose:
    This stored procedure performs the ETL(Extract, Transform, Load) Process to 
    populate the 'silver' schema tables from the 'bronze' schema.
  Actons Performed:
    -Truncates Silver tables.
    -Inserts transformed and cleansed data from Bronze into silver tables.

Parameters:
    None.
    This stored procedure des not accept any parameters or return any values.

Usage Exaample:
    EXEC Silver.load_silver;
=============================================================================================
*/




CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		
		SET @batch_start_time = GETDATE();
		PRINT '============================================================';
		PRINT 'Loading Bronze layer';
		PRINT '============================================================';

			--Customer_Info	

		PRINT '------------------------------------------------------------';
		PRINT 'Loading CRM table';
		PRINT '------------------------------------------------------------';

		SET @start_time= GETDATE();
		PRINT '>> Truncating Table:bronze.crm_cust_info <<';
		TRUNCATE TABLE bronze.crm_cust_info; --dropping data from table

		PRINT '>> Inserting data into:bronze.crm_cust_info <<';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Software\AI and ML\SQL\BARAA\Building a Modern Data Warehoue - Data Engineering Bootcamp Udemy\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.CSV'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK
			  );
		SET @end_time= GETDATE();
		PRINT '>>Load Duration: '+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';

		PRINT '----------------------------------';
			  --SELECT COUNT(*) FROM bronze.crm_cust_info;


			  --Prod_Info
		SET @start_time= GETDATE();
		PRINT '>> Truncating Table:bronze.crm_prod_info <<';
		TRUNCATE TABLE bronze.crm_prod_info; --dropping data from table

		PRINT '>> Inserting data into:bronze.crm_prod_info <<';
		BULK INSERT bronze.crm_prod_info
		FROM 'D:\Software\AI and ML\SQL\BARAA\Building a Modern Data Warehoue - Data Engineering Bootcamp Udemy\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.CSV'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK
			  );

		SET @end_time= GETDATE();
		PRINT '>>Load Duration: '+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';

		PRINT '----------------------------------';
			  --SELECT COUNT(*) FROM bronze.crm_prod_info;


			  -- crm sales
		SET @start_time= GETDATE();
		PRINT '>> Truncating Table:bronze.crm_sales_details <<';
		TRUNCATE TABLE bronze.crm_sales_details; --dropping data from table

		PRINT '>> Inserting data into:bronze.crm_sales_details <<';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Software\AI and ML\SQL\BARAA\Building a Modern Data Warehoue - Data Engineering Bootcamp Udemy\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.CSV'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK
			  );
		SET @end_time= GETDATE();
		PRINT '>>Load Duration: '+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';

		PRINT '----------------------------------';
			  --SELECT COUNT(*) FROM bronze.crm_sales_details;

		PRINT '------------------------------------------------------------';
		PRINT 'Loading ERP table';
		PRINT '------------------------------------------------------------';

			  --erp_cust_az12
		SET @start_time= GETDATE();
		PRINT '>> Truncating Table:bronze.erp_cust_az12 <<';
		TRUNCATE TABLE bronze.erp_cust_az12; --dropping data from table

		PRINT '>> Inserting data into:bronze.erp_cust_az12 <<';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Software\AI and ML\SQL\BARAA\Building a Modern Data Warehoue - Data Engineering Bootcamp Udemy\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.CSV'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK
			  );
		SET @end_time= GETDATE();
		PRINT '>>Load Duration: '+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';

		PRINT '----------------------------------';
			  --SELECT COUNT(*) FROM bronze.erp_cust_az12;


			  --bronze.erp_loc_a101
		SET @start_time= GETDATE();
		PRINT '>> Truncating Table:bronze.erp_loc_a101 <<';
		TRUNCATE TABLE bronze.erp_loc_a101; --dropping data from table

		PRINT '>> Inserting data into:bronze.erp_loc_a101 <<';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Software\AI and ML\SQL\BARAA\Building a Modern Data Warehoue - Data Engineering Bootcamp Udemy\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.CSV'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK
			  );
		SET @end_time= GETDATE();
		PRINT '>>Load Duration: '+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';

		PRINT '----------------------------------';
			  --SELECT COUNT(*) FROM bronze.erp_loc_a101;


			  --bronze.erp_px_cat_g1v2
		SET @start_time= GETDATE();
		PRINT '>> Truncating Table:bronze.erp_px_cat_g1v2 <<';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2; --dropping data from table

		PRINT '>> Inserting data into:bronze.erp_px_cat_g1v2 <<';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Software\AI and ML\SQL\BARAA\Building a Modern Data Warehoue - Data Engineering Bootcamp Udemy\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.CSV'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK
			  );		  
		SET @end_time= GETDATE();
		PRINT '>>Load Duration: '+ CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';

		PRINT '----------------------------------';

		SET @batch_end_time = GETDATE();
			  --SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;

		PRINT '============================================================';
		PRINT 'Loading Bronze layer is completed';
		PRINT ' -Total Load Duration: '+ CAST (DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR)+ ' seconds';
		PRINT '============================================================';

	END TRY
	BEGIN CATCH
		PRINT '==========================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================================';

	END CATCH

END;

