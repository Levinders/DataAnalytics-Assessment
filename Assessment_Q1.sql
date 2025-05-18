------------------------------------------------------------------------------------------------------
-- ABOUT: 
-- Queries in this file answers - High-Value Customers with Multiple Products:
-- find customers with at least one funded savings plan 
-- AND one funded investment plan, sorted by total deposits.
------------------------------------------------------------------------------------------------------

SELECT 
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS customer_name,
    ROUND(SUM(ss.confirmed_amount)) AS total_deposits
FROM users_customuser uc
 
JOIN savings_savingsaccount ss ON uc.id = ss.owner_id
JOIN plans_plan pp ON ss.plan_id = pp.id

WHERE 
    -- Only funded plans 
    ss.confirmed_amount > 0

GROUP BY uc.id, uc.first_name, uc.last_name

HAVING 
    -- At least one funded savings plan
    SUM(CASE WHEN pp.is_regular_savings = 1 THEN 1 ELSE 0 END) > 0
    AND
    -- At least one funded investment plan
    SUM(CASE WHEN pp.is_a_fund = 1 THEN 1 ELSE 0 END) > 0

ORDER BY total_deposits DESC;
