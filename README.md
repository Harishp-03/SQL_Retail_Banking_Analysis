# Retail Banking Transaction Analysis using MySQL

## 📌 Project Overview

The **Retail Banking Transaction Analysis** project focuses on analyzing retail banking data using MySQL to understand customer profiles, account activity, transaction patterns, loan performance, repayment behavior, and card usage.

The project follows a business analytics approach, moving from understanding business requirements and database relationships to writing SQL queries and identifying meaningful business insights.

## 🎯 Project Objectives

- Understand customer demographics, segmentation, income, credit scores, and KYC status.
- Analyze account types, balances, interest rates, and branch activity.
- Identify transaction patterns across transaction types, channels, and time periods.
- Evaluate loan amounts, outstanding balances, repayment delays, and penalties.
- Analyze card types, credit limits, outstanding balances, reward points, and card networks.
- Support data-driven banking decisions through SQL analysis.

## 🛠️ Tools & Technologies

- **MySQL** — Database creation, data management, and analysis
- **SQL** — Data querying and business analysis
- **GitHub** — Project version control and portfolio presentation

## 🗄️ Database Structure

The project uses a relational database named `retail_banking_analysis` with seven tables:

| Table | Description |
|---|---|
| `customers` | Customer profiles, segments, income, credit scores, and KYC status |
| `branches` | Branch details, locations, regions, and employee counts |
| `accounts` | Account types, balances, interest rates, and account status |
| `transactions` | Transaction dates, amounts, channels, and statuses |
| `loans` | Loan types, amounts, interest rates, and outstanding balances |
| `loan_payments` | Payment details, amounts, penalties, and repayment information |
| `cards` | Card types, credit limits, outstanding balances, and reward points |

Primary keys and foreign keys establish relationships between the tables.

## 📊 Project Workflow

### Sprint 1: Business Understanding
- Understand the retail banking business and analytical requirements.
- Study the Entity Relationship (ER) diagram.
- Identify relevant tables, columns, and relationships for business questions.

### Sprint 2: Database Setup
- Create the MySQL database and tables.
- Define primary keys, foreign keys, data types, and constraints.
- Import the provided CSV data and verify the database structure and row counts.

### Sprint 3: Basic Analysis
- Count customers, accounts, and loans.
- Identify account types, transaction types, loan types, and card types.
- Calculate the total amount of completed transactions and outstanding loan balances.

### Sprint 4: Objective-Based Analysis
- **Customer Segmentation:** Analyze demographics, income, credit scores, customer activity, KYC status, and tenure.
- **Account & Branch Analysis:** Compare account types, balances, interest rates, and branch activity.
- **Transaction Analysis:** Examine transaction volumes, amounts, channels, monthly trends, and customer segments.
- **Loan Analysis:** Compare loan types, loan amounts, outstanding balances, repayment delays, penalties, and payment methods.
- **Card Analysis:** Examine card types, credit limits, outstanding balances, reward points, networks, and multiple-card accounts.

## 💡 SQL Concepts Used

- `CREATE DATABASE` and `CREATE TABLE`
- Primary keys and foreign keys
- `SELECT`, `WHERE`, `ORDER BY`, and `DISTINCT`
- Aggregate functions: `COUNT()`, `SUM()`, and `AVG()`
- `GROUP BY` and `HAVING`
- `INNER JOIN`
- Subqueries
- Date functions such as `TIMESTAMPDIFF()` and `DATE_FORMAT()`
- `ROUND()` and `LIMIT`
- `UNION ALL`
- Database structure, relationship, and row-count verification

## 📈 Business Value

The analysis is designed to help banking teams understand customer segments, compare branch and account activity, monitor transaction trends, examine loan repayment behavior, and evaluate card product engagement.

The SQL queries provide a foundation for identifying patterns and supporting business decisions. Specific numerical findings should be added after reviewing the actual query outputs.

## 🚀 How to Run the Project

1. Clone or download this repository.
2. Open `Retail_Banking_Transaction_Analysis.sql` in MySQL Workbench or another compatible MySQL client.
3. Execute the database and table creation statements.
4. Import the provided CSV files into their corresponding tables, if you have access to the original dataset.
5. Verify table structures, foreign-key relationships, and row counts.
6. Execute the analytical queries and review the results.

**Note:** The analytical queries depend on the expected table structures and imported data. If you do not have the original CSV files, the database setup can be reviewed, but the analysis will require data to produce meaningful results.

## 📁 Repository Structure

```text
SQL-Retail-Banking-Analysis/
│
├── Retail_Banking_Transaction_Analysis.sql
└── README.md
```

Additional documentation, insights, or presentation files can be added to the repository when needed.

## 👨‍💻 Author

**Harish Patil**

B.Tech Computer Science Engineering | Aspiring Data Analyst

