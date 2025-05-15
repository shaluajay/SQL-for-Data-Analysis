# SQL-for-Data-Analysis
# Company Database SQL Practice

This repository contains a collection of SQL queries and procedures designed to explore and demonstrate core SQL functionalities using a sample `company_db` database.

##  Database Used
- **Database Name**: `company_db`
- **Tables Involved**: `employee`, `dependent`, `project`, `works_on`, `dept_locations`, `sample`, `t1`, `t2`

---

##  Key Features

- Use of **basic and advanced SQL queries**
- Demonstration of **joins** (INNER, LEFT, RIGHT, SELF, CROSS)
- Use of **aggregate functions** (`SUM`, `AVG`, `COUNT`)
- Usage of **subqueries** for nested filtering and analysis
- Application of **views**, **functions**, **stored procedures**, and **triggers**
- Use of **window functions** like `RANK()`, `ROW_NUMBER()`
- Use of **date and time functions** (`DATEDIFF`, `TIMESTAMPDIFF`)
- Query **optimization concepts** using indexes (in theory)

---

##  SQL Functionality Demonstrated

###  Basic Querying
- `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `LIMIT`, `OFFSET`
- Use of aliases and formatting for better readability

###  Joins
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `SELF JOIN`, `CROSS JOIN`

###  Aggregate Functions
- `SUM()`, `AVG()`, `COUNT()`, `DISTINCT`

###  Subqueries
- Nested subqueries for filtering based on related table data
- `IN`, `NOT IN`, `EXISTS`, correlated subqueries

###  Views
- Created views for simplified reporting and analysis

###  Stored Procedures
- Parameterized procedures with `IN`, `OUT`
- Business logic encapsulation (e.g., salary filtering, transaction logic)

###  User-Defined Functions
- Custom `addition(x, y, z)`
- `age(birthdate)`
- (Planned) Tax calculation by salary slabs

###  Window Functions
- `SUM() OVER()`, `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`



 



