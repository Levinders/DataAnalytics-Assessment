------------------------------------------------------------------------------------------------------
-- ABOUT: 
-- Queries in this file answers - Transaction Frequency Analysis:
-- Calculate the average number of transactions per customer per month and categorize them:
-- "High Frequency" (≥10 transactions/month)
-- "Medium Frequency" (3-9 transactions/month)
-- "Low Frequency" (≤2 transactions/month)
------------------------------------------------------------------------------------------------------

WITH monthly_counts AS (
    SELECT 
        DISTINCT owner_id,
        MONTH(transaction_date) AS month_num,
        COUNT(*) AS monthly_tranx
    FROM savings_savingsaccount
    GROUP BY owner_id, MONTH(transaction_date)
), 
user_avg AS (
    SELECT 
        DISTINCT owner_id,
        AVG(monthly_tranx) AS avg_tranx_per_month
    FROM monthly_counts
    GROUP BY owner_id
)
SELECT 
    CASE
        WHEN avg_tranx_per_month >= 10 THEN 'High Frequency'
        WHEN avg_tranx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category, 
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_tranx_per_month), 1) AS avg_transactions_per_month
FROM user_avg
GROUP BY frequency_category;







