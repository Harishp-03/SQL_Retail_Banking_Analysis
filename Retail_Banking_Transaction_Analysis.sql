-- ============================================================
-- RETAIL BANKING TRANSACTION ANALYSIS
-- COMPLETE DATABASE SETUP
-- ============================================================

-- STEP 1: Create a database

CREATE DATABASE retail_banking_analysis;

USE retail_banking_analysis;


-- ============================================================
-- STEP 2: BRANCHES TABLE
-- ============================================================

CREATE TABLE branches (
    branch_id VARCHAR(20) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    region VARCHAR(20) NOT NULL,
    opening_date DATE,
    employee_count INT
);


-- ============================================================
-- STEP 3: CUSTOMERS TABLE
-- ============================================================

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_since DATE,
    kyc_status VARCHAR(20),
    segment VARCHAR(30),
    annual_income DECIMAL(12,2),
    credit_score INT,
    is_active VARCHAR(10)
);


-- ============================================================
-- STEP 4: ACCOUNTS TABLE
-- ============================================================

CREATE TABLE accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(20) NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    open_date DATE NOT NULL,
    close_date DATE,
    current_balance DECIMAL(15,2) DEFAULT 0.00,
    interest_rate DECIMAL(5,2),
    overdraft_limit DECIMAL(12,2) DEFAULT 0.00,
    status VARCHAR(20) NOT NULL,

    CONSTRAINT fk_accounts_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_accounts_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);


-- ============================================================
-- STEP 5: LOANS TABLE
-- ============================================================

CREATE TABLE loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(20) NOT NULL,
    loan_type VARCHAR(30) NOT NULL,
    loan_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2),
    tenure_month INT,
    disbursement_date DATE,
    maturity_date DATE,
    emi_amount DECIMAL(12,2),
    outstanding_balance DECIMAL(15,2),
    loan_status VARCHAR(30),
    purpose VARCHAR(50),

    CONSTRAINT fk_loans_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_loans_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);


-- ============================================================
-- STEP 6: LOAN_PAYMENTS TABLE
-- ============================================================

CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    loan_id VARCHAR(20) NOT NULL,
    payment_date DATE,
    scheduled_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2),
    principal_paid DECIMAL(12,2),
    interest_paid DECIMAL(12,2),
    penalty DECIMAL(12,2),
    days_late INT,
    payment_method VARCHAR(30),
    status VARCHAR(20),

    CONSTRAINT fk_loan_payments_loan
        FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
);


-- ============================================================
-- STEP 7: CARDS TABLE
-- ============================================================

CREATE TABLE cards (
    card_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    card_type VARCHAR(20),
    issue_date DATE,
    expiry_date DATE,
    credit_limit DECIMAL(12,2),
    outstanding_balance DECIMAL(12,2),
    reward_points INT DEFAULT 0,
    is_active VARCHAR(10),
    network VARCHAR(20),

    CONSTRAINT fk_cards_account
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);


-- ============================================================
-- STEP 8: TRANSACTIONS TABLE
-- ============================================================

CREATE TABLE transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_time TIME,
    transaction_type VARCHAR(20),
    amount DECIMAL(15,2),
    channel VARCHAR(20),
    description VARCHAR(100),
    balance_after DECIMAL(15,2),
    status VARCHAR(20),

    CONSTRAINT fk_transactions_account
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

-- ============================================================
-- STEP 9: VERIFY ALL TABLES
-- ============================================================
SHOW TABLES;

-- ============================================================
-- STEP 10: VERIFY TABLE STRUCTURES
-- ============================================================

DESCRIBE branches;
DESCRIBE customers;
DESCRIBE accounts;
DESCRIBE loans;
DESCRIBE loan_payments;
DESCRIBE cards;
DESCRIBE transactions;

-- ============================================================
-- STEP 11: VERIFY FOREIGN KEY RELATIONSHIPS
-- ============================================================

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'retail_banking_analysis'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

-- ============================================================
-- STEP 12: VERIFY ROW COUNTS FOR ALL TABLES
-- ============================================================
USE retail_banking_analysis;
SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'branches', COUNT(*)
FROM branches

UNION ALL

SELECT 'accounts', COUNT(*)
FROM accounts

UNION ALL

SELECT 'cards', COUNT(*)
FROM cards

UNION ALL

SELECT 'loans', COUNT(*)
FROM loans

UNION ALL

SELECT 'loan_payments', COUNT(*)
FROM loan_payments

UNION ALL

SELECT 'transactions', COUNT(*)
FROM transactions;

USE retail_banking_analysis;

-- ============================================================
-- SPRINT 3: BASIC ANALYSIS / DATA EXPLORATION
-- ============================================================

-- QUESTION 11
-- What is the total number of customers?
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM customers;

-- ============================================================
-- QUESTION 12
-- What is the total number of accounts?
-- ============================================================

SELECT COUNT(*) AS total_accounts
FROM accounts;

-- ============================================================
-- QUESTION 13
-- What are the different account types available?
-- ============================================================

SELECT DISTINCT account_type
FROM accounts
ORDER BY account_type;

-- ============================================================
-- QUESTION 14
-- How many customers are currently active?
-- ============================================================

SELECT COUNT(*) AS active_customers
FROM customers
WHERE is_active = 'Yes';

-- ============================================================
-- QUESTION 15
-- What are the different transaction types available?
-- ============================================================

SELECT DISTINCT transaction_type
FROM transactions
ORDER BY transaction_type;

-- ============================================================
-- QUESTION 16
-- What is the total amount of completed transactions?
-- ============================================================

SELECT SUM(amount) AS total_completed_transaction_amount
FROM transactions
WHERE status = 'Completed';

-- ============================================================
-- QUESTION 17
-- What are the different loan types available?
-- ============================================================

SELECT DISTINCT loan_type
FROM loans
ORDER BY loan_type;

-- ============================================================
-- QUESTION 18
-- What is the total number of loans?
-- ============================================================

SELECT COUNT(*) AS total_loans
FROM loans;

-- ============================================================
-- QUESTION 19
-- What are the different card types available?
-- ============================================================

SELECT DISTINCT card_type
FROM cards
ORDER BY card_type;

-- ============================================================
-- QUESTION 20
-- What is the total outstanding loan balance?
-- ============================================================

SELECT SUM(outstanding_balance) AS total_outstanding_loan_balance
FROM loans;

USE retail_banking_analysis;

-- ============================================================
-- SPRINT 4: OBJECTIVE-BASED ANALYSIS
-- ============================================================
-- OBJECTIVE 4.1:
-- UNDERSTAND CUSTOMER PROFILE AND SEGMENTATION
-- Analytical questions formulated from the project instructions
-- ============================================================
-- ------------------------------------------------------------
-- Q21. How many customers are there in each customer segment?
-- ------------------------------------------------------------

SELECT
    segment,
    COUNT(*) AS customer_count
FROM customers
GROUP BY segment
ORDER BY customer_count DESC;

-- ------------------------------------------------------------
-- Q22. What is the distribution of customers by gender?
-- ------------------------------------------------------------

SELECT
    gender,
    COUNT(*) AS customer_count
FROM customers
GROUP BY gender
ORDER BY customer_count DESC;

-- ------------------------------------------------------------
-- Q23. Which cities have the highest number of customers?
-- ------------------------------------------------------------

SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- ------------------------------------------------------------
-- Q24. Which states have the highest number of customers?
-- ------------------------------------------------------------

SELECT
    state,
    COUNT(*) AS customer_count
FROM customers
GROUP BY state
ORDER BY customer_count DESC;

-- ------------------------------------------------------------
-- Q25. What is the average annual income for each customer segment?
-- ------------------------------------------------------------

SELECT
    segment,
    ROUND(AVG(annual_income), 2) AS average_annual_income
FROM customers
GROUP BY segment
ORDER BY average_annual_income DESC;

-- ------------------------------------------------------------
-- Q26. What is the average credit score for each customer segment?
-- ------------------------------------------------------------

SELECT
    segment,
    ROUND(AVG(credit_score), 2) AS average_credit_score
FROM customers
GROUP BY segment
ORDER BY average_credit_score DESC;

-- ------------------------------------------------------------
-- Q27. How many active and inactive customers are there?
-- ------------------------------------------------------------

SELECT
    is_active,
    COUNT(*) AS customer_count
FROM customers
GROUP BY is_active
ORDER BY customer_count DESC;

-- ------------------------------------------------------------
-- Q28. What is the KYC status distribution among customers?
-- ------------------------------------------------------------

SELECT
    kyc_status,
    COUNT(*) AS customer_count
FROM customers
GROUP BY kyc_status
ORDER BY customer_count DESC;

-- ------------------------------------------------------------
-- Q29. How long have customers been with the bank? Customer tenure is calculated in years.
-- ------------------------------------------------------------

SELECT
    customer_id,
    first_name,
    last_name,
    customer_since,
    TIMESTAMPDIFF(
        YEAR,
        customer_since,
        (SELECT MAX(transaction_date) FROM transactions)
    ) AS tenure_years
FROM customers
ORDER BY tenure_years DESC;

-- ------------------------------------------------------------
-- Q30. What is the average customer tenure for each segment?
-- ------------------------------------------------------------

SELECT
    segment,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                YEAR,
                customer_since,
                (SELECT MAX(transaction_date) FROM transactions)
            )
        ),
        2
    ) AS average_tenure_years
FROM customers
GROUP BY segment
ORDER BY average_tenure_years DESC;

-- ------------------------------------------------------------
-- Q31. Compare customer count, average income, and average credit score by segment.
-- ------------------------------------------------------------

SELECT
    segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(annual_income), 2) AS average_income,
    ROUND(AVG(credit_score), 2) AS average_credit_score
FROM customers
GROUP BY segment
ORDER BY customer_count DESC;

-- ------------------------------------------------------------
-- Q32. Which customer segments have the highest average income and credit score?
-- ------------------------------------------------------------

SELECT
    segment,
    ROUND(AVG(annual_income), 2) AS average_income,
    ROUND(AVG(credit_score), 2) AS average_credit_score
FROM customers
GROUP BY segment
ORDER BY average_income DESC, average_credit_score DESC;

-- ============================================================
-- SPRINT 4.2
-- UNDERSTAND ACCOUNT USAGE AND BRANCH ACTIVITY
-- ============================================================

-- ------------------------------------------------------------
-- Q33. How many accounts are there for each account type? Based on: Compare different account types.
-- ------------------------------------------------------------
SELECT
    account_type,
    COUNT(*) AS account_count
FROM accounts
GROUP BY account_type
ORDER BY account_count DESC;

-- ------------------------------------------------------------
-- Q34. What is the average account balance for each account type? Based on: Examine account balances.
-- ------------------------------------------------------------

SELECT
    account_type,
    ROUND(AVG(current_balance), 2) AS average_balance
FROM accounts
GROUP BY account_type
ORDER BY average_balance DESC;

-- ------------------------------------------------------------
-- Q35. Which customers have the highest number of accounts? Based on: Compare account activity across customers.
-- ------------------------------------------------------------

SELECT
    customer_id,
    COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id
ORDER BY account_count DESC;

-- ------------------------------------------------------------
-- Q36. How does account activity differ across branches? Based on: Compare account activity across branches.
-- ------------------------------------------------------------
SELECT
    branch_id,
    COUNT(*) AS account_count,
    ROUND(AVG(current_balance), 2) AS average_balance
FROM accounts
GROUP BY branch_id
ORDER BY account_count DESC;

-- ------------------------------------------------------------
-- Q37. What are the average interest rates across account types?
-- Based on: Look at interest rates across account types.
-- ------------------------------------------------------------
SELECT
    account_type,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM accounts
GROUP BY account_type
ORDER BY average_interest_rate DESC;

-- ------------------------------------------------------------
-- Q38. How many active and closed accounts are there?
-- Based on: Identify differences between active and closed accounts.
-- ------------------------------------------------------------

SELECT
    status,
    COUNT(*) AS account_count
FROM accounts
GROUP BY status
ORDER BY account_count DESC;

-- ------------------------------------------------------------
-- Q39. What is the total balance held in each account type?
-- Based on: Examine account balances.
-- ------------------------------------------------------------

SELECT
    account_type,
    ROUND(SUM(current_balance), 2) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;

-- ------------------------------------------------------------
-- Q40. Which branches have the highest total account balances?
-- Based on: Compare account activity across branches.
-- ------------------------------------------------------------
SELECT
    branch_id,
    COUNT(*) AS account_count,
    ROUND(SUM(current_balance), 2) AS total_balance
FROM accounts
GROUP BY branch_id
ORDER BY total_balance DESC;

-- ============================================================
-- SPRINT 4.3
-- ANALYZE TRANSACTION PATTERNS
-- ============================================================

-- ------------------------------------------------------------
-- Q41. How many transactions are there for each transaction type?
-- Based on: Compare different transaction types.
-- ------------------------------------------------------------
SELECT
    transaction_type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY transaction_type
ORDER BY transaction_count DESC;

-- ------------------------------------------------------------
-- Q42. What is the total transaction amount for each transaction type?
-- Based on: Compare different transaction types and examine amounts.
-- ------------------------------------------------------------
SELECT
    transaction_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

-- ------------------------------------------------------------
-- Q43. How many transactions are made through each channel?
-- Based on: Compare transactions across different channels.
-- ------------------------------------------------------------
SELECT
    channel,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY channel
ORDER BY transaction_count DESC;

-- ------------------------------------------------------------
-- Q44. What is the total transaction amount for each channel?
-- Based on: Compare transactions across different channels and examine transaction amounts.
-- ------------------------------------------------------------
SELECT
    channel,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY channel
ORDER BY total_amount DESC;

-- ------------------------------------------------------------
-- Q45. What is the average transaction amount for each transaction type?
-- Based on: Examine transaction amounts.
-- ------------------------------------------------------------
SELECT
    transaction_type,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM transactions
GROUP BY transaction_type
ORDER BY average_transaction_amount DESC;

-- ------------------------------------------------------------
-- Q46. What are the most common transaction descriptions?
-- Based on: Look at common transaction descriptions.
-- ------------------------------------------------------------
SELECT
    description,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY description
ORDER BY transaction_count DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Q47. How does transaction activity change over time by month?
-- Based on: Examine transaction activity over time.
-- ------------------------------------------------------------
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY transaction_month;

-- ------------------------------------------------------------
-- Q48. Which accounts have the highest transaction activity?
-- Based on: Compare transaction activity across accounts.
-- ------------------------------------------------------------
SELECT
    account_id,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY account_id
ORDER BY transaction_count DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Q49. Which customer groups have the highest transaction activity?
-- Based on: Compare transaction activity across customer groups.
-- ------------------------------------------------------------
SELECT
    c.segment,
    COUNT(t.transaction_id) AS transaction_count,
    ROUND(SUM(t.amount), 2) AS total_transaction_amount
FROM transactions t
JOIN accounts a
    ON t.account_id = a.account_id
JOIN customers c
    ON a.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY transaction_count DESC;

-- ------------------------------------------------------------
-- Q50. How do transactions affect account balances?
-- Based on: Look at how transaction activity affects account balances.
-- ------------------------------------------------------------
SELECT
    account_id,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_amount,
    ROUND(MAX(balance_after), 2) AS latest_balance_after
FROM transactions
GROUP BY account_id
ORDER BY transaction_count DESC
LIMIT 10;

-- ============================================================
-- SPRINT 4.4
-- EVALUATE LOAN PERFORMANCE AND REPAYMENT BEHAVIOUR
-- ============================================================

-- ------------------------------------------------------------
-- Q51. How many loans are there for each loan type?
-- Based on: Compare different loan types.
-- ------------------------------------------------------------
SELECT
    loan_type,
    COUNT(*) AS loan_count
FROM loans
GROUP BY loan_type
ORDER BY loan_count DESC;

-- ------------------------------------------------------------
-- Q52. How many loans are there for each loan purpose?
-- Based on: Compare loans based on their purpose.
-- ------------------------------------------------------------
SELECT
    purpose,
    COUNT(*) AS loan_count
FROM loans
GROUP BY purpose
ORDER BY loan_count DESC;

-- ------------------------------------------------------------
-- Q53. What are the total loan amounts and outstanding balances for each loan type?
-- Based on: Examine loan amounts and outstanding balances.
-- ------------------------------------------------------------
SELECT
    loan_type,
    COUNT(*) AS loan_count,
    ROUND(SUM(loan_amount), 2) AS total_loan_amount,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY total_loan_amount DESC;

-- ------------------------------------------------------------
-- Q54. What is the average loan amount and outstanding balance for each loan type?
-- Based on: Examine loan amounts and outstanding balances.
-- ------------------------------------------------------------
SELECT
    loan_type,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount,
    ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM loans
GROUP BY loan_type
ORDER BY average_loan_amount DESC;

-- ------------------------------------------------------------
-- Q55. Which customers have the highest outstanding loan balances?
-- ------------------------------------------------------------
SELECT
    customer_id,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM loans
GROUP BY customer_id
ORDER BY total_outstanding_balance DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Q56. Which branches have the highest total loan amounts?
-- ------------------------------------------------------------
SELECT
    branch_id,
    ROUND(SUM(loan_amount), 2) AS total_loan_amount
FROM loans
GROUP BY branch_id
ORDER BY total_loan_amount DESC;

-- ------------------------------------------------------------
-- Q57. What is the average loan tenure for each loan type?
-- ------------------------------------------------------------
SELECT
    loan_type,
    ROUND(AVG(tenure_month), 2) AS average_tenure_months
FROM loans
GROUP BY loan_type
ORDER BY average_tenure_months DESC;

-- ------------------------------------------------------------
-- Q58. What is the total number of loans and total loan amount by branch?
-- ------------------------------------------------------------
SELECT
    branch_id,
    COUNT(*) AS loan_count,
    ROUND(SUM(loan_amount), 2) AS total_loan_amount
FROM loans
GROUP BY branch_id
ORDER BY total_loan_amount DESC;

-- ------------------------------------------------------------
-- Q59. Which loans have repayment delays?
-- ------------------------------------------------------------
SELECT
    lp.loan_id,
    COUNT(*) AS delayed_payment_count
FROM loan_payments lp
WHERE lp.payment_date > lp.due_date
GROUP BY lp.loan_id
ORDER BY delayed_payment_count DESC;


-- ------------------------------------------------------------
-- Q60. What is the total penalty amount by loan type?
-- ------------------------------------------------------------
SELECT
    l.loan_type,
    ROUND(SUM(lp.penalty_amount), 2) AS total_penalty_amount
FROM loans l
JOIN loan_payments lp
    ON l.loan_id = lp.loan_id
GROUP BY l.loan_type
ORDER BY total_penalty_amount DESC;


-- ------------------------------------------------------------
-- Q61. Which branches have the highest late-payment activity?
-- ------------------------------------------------------------
SELECT
    b.branch_id,
    b.branch_name,
    COUNT(*) AS late_payment_count
FROM loan_payments lp
JOIN loans l
    ON lp.loan_id = l.loan_id
JOIN branches b
    ON l.branch_id = b.branch_id
WHERE lp.payment_date > lp.due_date
GROUP BY b.branch_id, b.branch_name
ORDER BY late_payment_count DESC;


-- ------------------------------------------------------------
-- Q62. Which payment methods are most commonly used?
-- ------------------------------------------------------------
SELECT
    payment_method,
    COUNT(*) AS payment_count
FROM loan_payments
GROUP BY payment_method
ORDER BY payment_count DESC;

-- =====================================================
-- SPRINT 4.5 - CARD USAGE & PRODUCT ENGAGEMENT
-- =====================================================

USE retail_banking_analysis;
-- ------------------------------------------------------------
-- Q63. How many cards are there for each card type?
-- ------------------------------------------------------------
SELECT
    card_type,
    COUNT(*) AS card_count
FROM cards
GROUP BY card_type
ORDER BY card_count DESC;

-- ------------------------------------------------------------
-- Q64. What is the average credit limit for each card type?
-- ------------------------------------------------------------
SELECT
    card_type,
    ROUND(AVG(credit_limit), 2) AS average_credit_limit
FROM cards
GROUP BY card_type
ORDER BY average_credit_limit DESC;

-- ------------------------------------------------------------
-- Q65. What is the total credit limit for each card type?
-- ------------------------------------------------------------
SELECT
    card_type,
    ROUND(SUM(credit_limit), 2) AS total_credit_limit
FROM cards
GROUP BY card_type
ORDER BY total_credit_limit DESC;

-- ------------------------------------------------------------
-- Q66. What is the average outstanding balance for each card type?
-- ------------------------------------------------------------
SELECT
    card_type,
    ROUND(AVG(outstanding_balance), 2) AS average_outstanding_balance
FROM cards
GROUP BY card_type
ORDER BY average_outstanding_balance DESC;

-- ------------------------------------------------------------
-- Q67. What is the total outstanding balance for each card type?
-- ------------------------------------------------------------
SELECT
    card_type,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM cards
GROUP BY card_type
ORDER BY total_outstanding_balance DESC;

-- ------------------------------------------------------------
-- Q68. How many active and inactive cards are there?
-- ------------------------------------------------------------
SELECT
    is_active,
    COUNT(*) AS card_count
FROM cards
GROUP BY is_active
ORDER BY card_count DESC;

-- ------------------------------------------------------------
-- Q69. What is the average reward points for each card type?
-- ------------------------------------------------------------
SELECT
    card_type,
    ROUND(AVG(reward_points), 2) AS average_reward_points
FROM cards
GROUP BY card_type
ORDER BY average_reward_points DESC;

-- ------------------------------------------------------------
-- Q70. Which card network has the highest number of cards?
-- ------------------------------------------------------------
SELECT
    network,
    COUNT(*) AS card_count
FROM cards
GROUP BY network
ORDER BY card_count DESC;

-- ------------------------------------------------------------
-- Q71. What is the total outstanding balance by card network?
-- ------------------------------------------------------------
SELECT
    network,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM cards
GROUP BY network
ORDER BY total_outstanding_balance DESC;

-- ------------------------------------------------------------
-- Q72. Which accounts have multiple cards?
-- ------------------------------------------------------------
SELECT
    account_id,
    COUNT(*) AS card_count
FROM cards
GROUP BY account_id
HAVING COUNT(*) > 1
ORDER BY card_count DESC;

-- ------------------------------------------------------------
-- Q73. Which accounts have the highest total card outstanding balance?
-- ------------------------------------------------------------
SELECT
    account_id,
    ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM cards
GROUP BY account_id
ORDER BY total_outstanding_balance DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Q74. Which card types have the highest average reward points?
-- ------------------------------------------------------------
SELECT
    card_type,
    ROUND(AVG(reward_points), 2) AS average_reward_points
FROM cards
GROUP BY card_type
ORDER BY average_reward_points DESC;

USE retail_banking_analysis;

SHOW TABLES;
