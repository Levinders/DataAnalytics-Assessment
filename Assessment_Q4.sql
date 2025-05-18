------------------------------------------------------------------------------------------------------
-- ABOUT: 
-- Queries in this file answers - Customer Lifetime Value (CLV) Estimation
-- For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest
------------------------------------------------------------------------------------------------------

SELECT 
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()) AS tenure_months,
    COUNT(ss.id) AS total_transactions,
    ROUND(((SUM(ss.confirmed_amount) / NULLIF(TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()), 0)) * 12 * 0.001), 2) AS estimated_clv
FROM users_customuser uc

JOIN savings_savingsaccount ss ON uc.id = ss.owner_id

GROUP BY uc.id, name
ORDER BY estimated_clv DESC;




