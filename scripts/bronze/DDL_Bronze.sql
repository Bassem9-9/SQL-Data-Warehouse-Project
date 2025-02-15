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

if OBJECT_ID ('bronze.crm_cust_info' , 'U')
is not null
DROP table bronze.crm_cust_info

create table bronze.crm_cust_info (
	cst_id int,
	cst_key Nvarchar(50),
	cst_firstname  Nvarchar(50),
	cst_lastname  Nvarchar(50),
	cst_marital_status char(1),
	cst_gndr char(1),
	cst_create_date date
);
go
if OBJECT_ID ('bronze.crm_prd_info' , 'U')
is not null
drop table bronze.crm_prd_info
create table bronze.crm_prd_info (
	prd_id int,
	prd_key  Nvarchar(50),
	prd_nm Nvarchar(50),
	prd_cost int,
	prd_line char(2),
	prd_start_dt date,
	prd_end_dt date
);
go
if object_id('bronze.crm_sales_details' , 'U')
is not null
drop table bronze.crm_sales_details
create table bronze.crm_sales_details (
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales int,
	sls_quantity INT,
	sls_price int
);
go
if OBJECT_ID ('bronze.erp_CUST_AZ12' , 'U')
is not null 
drop table bronze.erp_CUST_AZ12
create table bronze.erp_CUST_AZ12 (
	CID nvarchar(50),
	BDATE date,
	GEN char(10)
);
go
if OBJECT_ID ('bronze.erp_LOC_A101' , 'U')
is not null
drop table bronze.erp_LOC_A101
create table bronze.erp_LOC_A101 (
	CID nvarchar(50),
	CNTRY nvarchar(50),
);
go
if OBJECT_ID('bronze.erp_PX_CAT_G1V2', 'U')
is not null
drop table bronze.erp_PX_CAT_G1V2
create table bronze.erp_PX_CAT_G1V2 (
	ID nvarchar(50),
	CAT nvarchar(50),
	SUBCAT nvarchar(50),
	MAINTENANCE char(4)
);

