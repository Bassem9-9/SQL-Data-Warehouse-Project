/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER proc bronze.load_bronze AS
begin
	Begin Try
	Print '==================================';
	Print 'Loading Bronz Layer';
	print '==================================';

	Print '----------------------------------';
	print 'Loading CRM Tables';
	Print '----------------------------------';

Print '-->truncating table [bronze].[crm_cust_info]'
	truncate table  [bronze].[crm_cust_info];
print 'Inserting table: [bronze].[crm_cust_info]'
	BULK INSERT [bronze].[crm_cust_info]
from 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with
(
	FIRSTROW = 2,
	fieldterminator = ',',
	TABLOCK	
)
Print '--> truncating table [bronze].[crm_prd_info]'
	truncate table [bronze].[crm_prd_info];
print 'Inserting table: [bronze].[crm_prd_info]'
	BULK INSERT [bronze].[crm_prd_info]
from 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with
(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
)
Print '--> truncating table [bronze].[crm_sales_details]'
	truncate table [bronze].[crm_sales_details]
print 'Inserting table: [bronze].[[crm_sales_details]]'
	BULK INSERT [bronze].[crm_sales_details]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH 
(
	FIRSTROW = 2 ,
	FIELDTERMINATOR = ',' 
)

	Print '----------------------------------';
	print 'Loading ERP Tables';
	Print '----------------------------------';
Print '--> truncating table [bronze].[erp_CUST_AZ12]'
	truncate table [bronze].[erp_CUST_AZ12];
print 'Inserting table: [bronze].[erp_CUST_AZ12]'
	BULK INSERT [bronze].[erp_CUST_AZ12]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH 
(
	FIRSTROW = 2 ,
	FIELDTERMINATOR = ',',
	TABLOCK
)
Print '--> truncating table [bronze].[erp_LOC_A101]'
	truncate table [bronze].[erp_LOC_A101]
print 'Inserting table: [bronze].[erp_LOC_A101]'
	BULK INSERT [bronze].[erp_LOC_A101]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
FIRSTROW = 2 ,
FIELDTERMINATOR = ',' ,
TABLOCK
)
Print '--> truncating table [bronze].[erp_PX_CAT_G1V2]'
	truncate table [bronze].[erp_PX_CAT_G1V2]
print 'Inserting table: [bronze].[erp_PX_CAT_G1V2]'
BULK INSERT [bronze].[erp_PX_CAT_G1V2]
FROM 'D:\DDS\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH 
(
	FIRSTROW = 2 , 
	FIELDTERMINATOR = ',' , 
	TABLOCK
)
	End Try
		Begin Catch
			Print 'Error During Loading Bronze Layer'
			Print 'Error Message ' + Error_message();
			print 'Error Number ' + cast(Error_Number() as char)
		End Catch
end
