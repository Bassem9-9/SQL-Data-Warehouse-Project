/*
=====================================================================
Create Database and Schemas
=====================================================================

Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
  */


use master 
create database DataWarehouse;
use DataWarehouse

-- create Schemas

create schema bronze 
go
create schema silver 
go
create schema gold 
