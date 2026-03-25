# 📊 Online Bookstore SQL Analysis


This project focuses on analyzing an online bookstore dataset using SQL to extract insights related to sales, customers, and inventory.

## Dataset
The dataset contains information about:
- Books
- Customers
- Orders

The data was originally stored in Excel files and then imported into MySQL for analysis.

## Objectives
The project answers several business questions such as:

- Who is the highest spending customer?
- Which books are ordered the most?
- How much inventory remains after fulfilling orders?
- Which cities have the most customers?

  
## Key Insights
- A small group of customers contributes significantly to total revenue.
- Certain genres dominate book sales.
- Some books have very low remaining stock after fulfilling orders.
- Order patterns vary across customers and categories.

## Tools Used
- MySQL
- SQL
- Microsoft Excel

## Key SQL Concepts
- JOIN
- LEFT JOIN
- GROUP BY
- SUM()
- COALESCE()

## Project Files
- `Books.csv.xlsx` – book dataset
- `Customers.csv.xlsx` – customer dataset
- `Orders.csv.xlsx` – order dataset
- `bookstore_analysis_queries.sql` – SQL queries used for analysis
