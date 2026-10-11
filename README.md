# 🎬 Sakila DVD Rental Database Analysis (SQL)

## 📌 Project Overview
This project demonstrates advanced SQL querying skills using the relational **Sakila Movie Rental Database**. It answers complex business questions regarding inventory management, customer rental history, store revenue performance, and catalog optimization.

🔗 **SQL Script File:** [sakila_queries.sql](sakila_queries.sql)

## 🎯 Key Business Questions & SQL Concepts Solved
1. **Catalog Filtering & Constraints:** Filtered PG-13 films under $2.99 and located movies with specific special features using `LIKE`.
2. **Customer Activity Tracking:** Counted active customers and extracted distinct customer rental histories for specific dates using `JOIN` and `DATE()` truncation.
3. **Daily Performance & Revenue:** Analyzed daily rental counts to find the busiest dates, and calculated daily revenue and rental volume for Store 1 using multi-table joins with `SUM()` and `COUNT()`.
4. **Inventory & Business Optimization:** 
   * Identified top customers by total rental volume using `GROUP BY` and `ORDER BY`.
   * Used Common Table Expressions (CTEs) to find underperforming movies with low lifetime rentals for catalog discontinuation.
   * Queried unreturned movies using `IS NULL` checks.

## 🛠️ Tech Stack & Skills
* **Database:** MySQL
* **Key SQL Concepts:** Multi-table Inner Joins, Aggregate Functions (`SUM`, `COUNT`), Date Extraction (`DATE()`), Filtering (`WHERE`, `HAVING`), Sorting (`ORDER BY`, `LIMIT`), and CTEs (`WITH` clause).
