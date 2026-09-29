# Modern Sales Data Warehouse with SQL Server

## Project Overview
The objective of this project was to design and implement a SQL Server-based Sales Data
Warehouse that integrates data from CRM and ERP source systems and transforms it into a reliable,
analytics-ready dimensional model.

## Objectives
- Design and implement a scalable data warehouse
- Develop efficient ETL processes
- Create structured data models (Star schema)
- Enable data analysis and reporting

## Tools & Technologies
- SQL Server
- VS Code / SQL Server Management Studio

## Project Structure
The warehouse follows a three-layer architecture:

## Bronze → Silver → Gold

## Bronze Layer
The Bronze layer stores the source data with minimal transformation. Its purpose is to preserve the original
data and provide a reliable starting point for the ETL process.
Six Bronze tables from CSV files that were created from the CRM and ERP source systems.

## Silver Layer

The Silver layer was responsible for cleaning and standardizing the source data.

Activities performed included:

- Data cleaning and standardization
- Duplicate detection and removal
- Data-type conversion
- NULL-value investigation
- Key standardization
- Data-quality checks
- Validation
- ETL audit logging
- 
## Gold Layer
The Gold layer contains business-ready dimension and fact tables designed for analytical reporting.
The final Gold model consists of:
- gold.dim_customers
- gold.dim_location
- gold.dim_category
- gold.dim_products
- gold.dim_date
- gold.fact_sale

## ETL Process
- **Extract** – Load raw data from source systems
- **Transform** – Clean, filter, and structure data
- **Load** – Store processed data into warehouse tables

## Data Modeling
- Fact and Dimension tables
- Star Schema design
- Optimized for analytical queries

## Analytics
- SQL queries for insights
- Aggregations and KPIs
- (Optional) Integration with Power BI for dashboards

## Contributing
- Contributions are welcome! Feel free to fork the repo and submit a pull request.

## License
- This project is open-source and available under the MIT License.
