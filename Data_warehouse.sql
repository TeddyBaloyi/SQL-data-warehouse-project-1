*/
===========================================
 Project: Modern Data Warehouse
 Author: Teddy Baloyi
 Date: 2026-04-30
 Description: Create database and Three Schemas(bronze, silver and gold)
===========================================
*/

-- Use master database

USE master;
GO

--Drop and create the Data_warehouse (Database)
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Data_warehouse')
BEGIN
    ALTER DATABASE Data_warehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Data_warehouse;
END;
GO

--Creating Data_warehouse
CREATE DATABASE Data_warehouse;
GO

USE Data_warehouse;
GO
 
--Creating Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO