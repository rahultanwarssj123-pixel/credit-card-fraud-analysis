-- =========================================================
-- CREDIT CARD FRAUD ANALYSIS PROJECT
-- PostgreSQL Analytical Query Documentation
-- =========================================================
-- Author: Rahul Tanwar
-- Tools Used:
-- PostgreSQL | pgAdmin | Python | Tableau
--
-- Project Focus:
-- Fraud detection analysis, financial risk
-- assessment, behavioral spending analysis,
-- and merchant-level fraud intelligence.
-- =========================================================



-- =========================================================
-- SECTION 1 — CORE FRAUD KPI ANALYSIS
-- =========================================================



-- =========================================================
-- QUERY 01 — FRAUD KPI OVERVIEW
-- =========================================================
-- Purpose:
-- Measure the overall fraud exposure within
-- the transaction ecosystem by calculating
-- total transactions, fraud volume, and
-- fraud percentage.
-- =========================================================

SELECT

    COUNT(*) AS total_transactions,

    -- Total number of fraudulent transactions
    SUM(is_fraud) AS total_fraud_transactions,

    -- Overall fraud rate across all transactions
    ROUND(
        (SUM(is_fraud)::numeric / COUNT(*)) * 100,
        2
    ) AS fraud_percentage

FROM fraud_transactions;



-- =========================================================
-- QUERY 02 — FRAUD ANALYSIS BY TRANSACTION CATEGORY
-- =========================================================
-- Purpose:
-- Evaluate fraud concentration across
-- transaction categories to identify
-- high-risk business segments.
-- =========================================================

SELECT

    category,

    -- Total transaction volume per category
    COUNT(*) AS total_transactions,

    -- Number of fraudulent transactions
    SUM(is_fraud) AS total_fraud_transactions,

    -- Fraud rate within each category
    ROUND(
        (SUM(is_fraud)::numeric / COUNT(*)) * 100,
        2
    ) AS fraud_percentage

FROM fraud_transactions

GROUP BY category

-- Prioritize categories with highest fraud rates
ORDER BY fraud_percentage DESC;



-- =========================================================
-- SECTION 2 — RISK SEGMENTATION ANALYSIS
-- =========================================================



-- =========================================================
-- QUERY 03 — RISK SEGMENTATION USING CTE
-- =========================================================
-- Purpose:
-- Segment transactions into predefined
-- risk bands based on transaction amount
-- and evaluate fraud concentration within
-- each segment.
-- =========================================================

WITH risk_classification AS (

    SELECT

        amt,
        is_fraud,

        -- Transaction risk classification
        CASE

            WHEN amt < 50 THEN 'Low Risk'

            WHEN amt BETWEEN 50 AND 500 THEN 'Medium Risk'

            ELSE 'High Risk'

        END AS risk_level

    FROM fraud_transactions
)

SELECT

    risk_level,

    COUNT(*) AS total_transactions,

    SUM(is_fraud) AS total_fraud_transactions,

    ROUND(
        (SUM(is_fraud)::numeric / COUNT(*)) * 100,
        2
    ) AS fraud_percentage

FROM risk_classification

GROUP BY risk_level

ORDER BY fraud_percentage DESC;



-- =========================================================
-- SECTION 3 — WINDOW FUNCTION ANALYSIS
-- =========================================================



-- =========================================================
-- QUERY 04 — CATEGORY FRAUD RANKING
-- =========================================================
-- Purpose:
-- Rank transaction categories based on
-- fraud percentage using window functions
-- to prioritize fraud-prone segments.
-- =========================================================

WITH category_fraud_analysis AS (

    SELECT

        category,

        COUNT(*) AS total_transactions,

        SUM(is_fraud) AS total_fraud_transactions,

        ROUND(
            (SUM(is_fraud)::numeric / COUNT(*)) * 100,
            2
        ) AS fraud_percentage

    FROM fraud_transactions

    GROUP BY category
)

SELECT

    category,

    total_transactions,

    total_fraud_transactions,

    fraud_percentage,

    -- Fraud ranking by category
    RANK() OVER (
        ORDER BY fraud_percentage DESC
    ) AS fraud_rank

FROM category_fraud_analysis;



-- =========================================================
-- QUERY 05 — RANK() VS DENSE_RANK()
-- =========================================================
-- Purpose:
-- Compare ranking behavior across categories
-- when duplicate fraud percentages occur.
-- =========================================================

WITH category_fraud_analysis AS (

    SELECT

        category,

        ROUND(
            (SUM(is_fraud)::numeric / COUNT(*)) * 100,
            2
        ) AS fraud_percentage

    FROM fraud_transactions

    GROUP BY category
)

SELECT

    category,

    fraud_percentage,

    -- Ranking with gaps after ties
    RANK() OVER (
        ORDER BY fraud_percentage DESC
    ) AS rank_position,

    -- Ranking without gaps after ties
    DENSE_RANK() OVER (
        ORDER BY fraud_percentage DESC
    ) AS dense_rank_position

FROM category_fraud_analysis;



-- =========================================================
-- QUERY 06 — ROW NUMBER ANALYSIS
-- =========================================================
-- Purpose:
-- Assign unique sequential identifiers to
-- transaction categories based on fraud
-- percentage ranking.
-- =========================================================

WITH category_fraud_analysis AS (

    SELECT

        category,

        ROUND(
            (SUM(is_fraud)::numeric / COUNT(*)) * 100,
            2
        ) AS fraud_percentage

    FROM fraud_transactions

    GROUP BY category
)

SELECT

    category,

    fraud_percentage,

    ROW_NUMBER() OVER (
        ORDER BY fraud_percentage DESC
    ) AS row_number

FROM category_fraud_analysis;



-- =========================================================
-- SECTION 4 — MERCHANT RISK ANALYSIS
-- =========================================================



-- =========================================================
-- QUERY 07 — MERCHANT FRAUD RANKING BY CATEGORY
-- =========================================================
-- Purpose:
-- Rank merchants based on fraud transaction
-- counts within individual transaction
-- categories.
-- =========================================================

WITH merchant_fraud_analysis AS (

    SELECT

        category,

        merchant,

        COUNT(*) AS fraud_transaction_count

    FROM fraud_transactions

    WHERE is_fraud = 1

    GROUP BY category, merchant
)

SELECT

    category,

    merchant,

    fraud_transaction_count,

    ROW_NUMBER() OVER (

        PARTITION BY category

        ORDER BY fraud_transaction_count DESC

    ) AS merchant_rank

FROM merchant_fraud_analysis;



-- =========================================================
-- QUERY 08 — TOP 3 FRAUDULENT MERCHANTS PER CATEGORY
-- =========================================================
-- Purpose:
-- Identify the highest-risk merchants within
-- each transaction category based on fraud
-- transaction frequency.
-- =========================================================

WITH merchant_fraud_analysis AS (

    SELECT

        category,

        merchant,

        COUNT(*) AS fraud_transaction_count

    FROM fraud_transactions

    WHERE is_fraud = 1

    GROUP BY category, merchant
),

ranked_merchants AS (

    SELECT

        category,

        merchant,

        fraud_transaction_count,

        ROW_NUMBER() OVER (

            PARTITION BY category

            ORDER BY fraud_transaction_count DESC

        ) AS merchant_rank

    FROM merchant_fraud_analysis
)

SELECT

    category,

    merchant,

    fraud_transaction_count,

    merchant_rank

FROM ranked_merchants

WHERE merchant_rank <= 3

ORDER BY category, merchant_rank;



-- =========================================================
-- SECTION 5 — SPENDING & FINANCIAL ANALYSIS
-- =========================================================



-- =========================================================
-- QUERY 09 — TOTAL SPENDING BY CATEGORY
-- =========================================================
-- Purpose:
-- Analyze customer spending distribution
-- across transaction categories to identify
-- major transaction ecosystems.
-- =========================================================

SELECT

    category,

    -- Total spending volume per category
    ROUND(
        SUM(amt)::numeric,
        2
    ) AS total_spending,

    -- Average transaction value
    ROUND(
        AVG(amt)::numeric,
        2
    ) AS avg_transaction_amount,

    -- Total transaction volume
    COUNT(*) AS total_transactions

FROM fraud_transactions

GROUP BY category

-- Prioritize categories by spending volume
ORDER BY total_spending DESC;



-- =========================================================
-- QUERY 10 — FINANCIAL FRAUD EXPOSURE BY CATEGORY
-- =========================================================
-- Purpose:
-- Measure total financial loss generated
-- by fraudulent transactions across
-- transaction categories.
-- =========================================================

SELECT

    category,

    -- Number of fraudulent transactions
    COUNT(*) AS fraud_transaction_count,

    -- Total fraud-related financial exposure
    ROUND(
        SUM(amt)::numeric,
        2
    ) AS total_fraud_amount,

    -- Average fraudulent transaction amount
    ROUND(
        AVG(amt)::numeric,
        2
    ) AS avg_fraud_amount,

    -- Largest fraudulent transaction observed
    ROUND(
        MAX(amt)::numeric,
        2
    ) AS max_fraud_amount

FROM fraud_transactions

WHERE is_fraud = 1

GROUP BY category

-- Prioritize categories by fraud losses
ORDER BY total_fraud_amount DESC;



-- =========================================================
-- SECTION 6 — BEHAVIORAL COMPARISON ANALYSIS
-- =========================================================



-- =========================================================
-- QUERY 11 — FRAUD VS NON-FRAUD SPENDING BEHAVIOR
-- =========================================================
-- Purpose:
-- Compare behavioral spending patterns
-- between fraudulent and legitimate
-- transactions across categories.
-- =========================================================

SELECT

    category,

    is_fraud,

    -- Total transaction count
    COUNT(*) AS total_transactions,

    -- Average transaction value
    ROUND(
        AVG(amt)::numeric,
        2
    ) AS avg_transaction_amount,

    -- Total transaction value
    ROUND(
        SUM(amt)::numeric,
        2
    ) AS total_transaction_amount

FROM fraud_transactions

GROUP BY category, is_fraud

ORDER BY category, is_fraud DESC;
