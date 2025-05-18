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
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(((SUM(s.confirmed_amount) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * 0.001), 2) AS estimated_clv
FROM users_customuser u

JOIN savings_savingsaccount s ON u.id = s.owner_id

GROUP BY u.id, name
ORDER BY estimated_clv DESC;
