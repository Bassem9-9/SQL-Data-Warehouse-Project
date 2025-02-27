/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

CREATE OR ALTER proc silver.load_silver AS
begin
	Begin Try
	Print '==================================';
	Print 'Loading Bronz Layer';
	print '==================================';

	Print '----------------------------------';
	print 'Loading CRM Tables';
	Print '----------------------------------';

Print '-->truncating table [silver].[crm_cust_info]'
	truncate table  [silver].[crm_cust_info];
print 'Inserting table: [silver].[crm_cust_info]'
	BULK INSERT [silver].[crm_cust_info]
from 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with
(
	FIRSTROW = 2,
	fieldterminator = ',',
	TABLOCK	
)
Print '--> truncating table [silver].[crm_prd_info]'
	truncate table [silver].[crm_prd_info];
print 'Inserting table: [silver].[crm_prd_info]'
	BULK INSERT [silver].[crm_prd_info]
from 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
)
Print '--> truncating table [silver].[crm_sales_details]'
	truncate table [silver].[crm_sales_details]
print 'Inserting table: [silver].[[crm_sales_details]]'
	BULK INSERT [silver].[crm_sales_details]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH 
(
	FIRSTROW = 2 ,
	FIELDTERMINATOR = ',' 
)

	Print '----------------------------------';
	print 'Loading ERP Tables';
	Print '----------------------------------';
Print '--> truncating table [silver].[erp_CUST_AZ12]'
	truncate table [silver].[erp_CUST_AZ12];
print 'Inserting table: [silver].[erp_CUST_AZ12]'
	BULK INSERT [silver].[erp_CUST_AZ12]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH 
(
	FIRSTROW = 2 ,
	FIELDTERMINATOR = ',',
	TABLOCK
)
Print '--> truncating table [silver].[erp_LOC_A101]'
	truncate table [silver].[erp_LOC_A101]
print 'Inserting table: [silver].[erp_LOC_A101]'
	BULK INSERT [silver].[erp_LOC_A101]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
FIRSTROW = 2 ,
FIELDTERMINATOR = ',' ,
TABLOCK
)
Print '--> truncating table [silver].[erp_PX_CAT_G1V2]'
	truncate table [silver].[erp_PX_CAT_G1V2]
print 'Inserting table: [silver].[erp_PX_CAT_G1V2]'
BULK INSERT [silver].[erp_PX_CAT_G1V2]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH 
(
	FIRSTROW = 2 , 
	FIELDTERMINATOR = ',' , 
	TABLOCK
)
	End Try
		Begin Catch
			Print 'Error During Loading silver Layer'
			Print 'Error Message ' + Error_message();
			print 'Error Number ' + cast(Error_Number() as char)
		End Catch
end
