------------------------------------------------------------------------------------------------------
-- ABOUT: 
-- Queries in this file answers - Account Inactivity Alert:
-- Find all active accounts (savings or investments) 
-- with no transactions in the last 1 year (365 days)
------------------------------------------------------------------------------------------------------

-- First SELECT (gets all investment accounts)
SELECT
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM plans_plan p

LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id

WHERE p.is_deleted = 0
  AND p.is_archived = 0
  AND p.is_a_fund = 1

GROUP BY p.id, p.owner_id 
HAVING last_transaction_date IS NULL OR inactivity_days > 365

UNION ALL

-- Second SELECT (gets all savings account)
SELECT
    p.id AS plan_id,
    p.owner_id,
    'Savings' AS type,
    MAX(DATE(s.transaction_date)) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM plans_plan p

LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id

WHERE p.is_deleted = 0
  AND p.is_archived = 0
  AND p.is_regular_savings = 1

GROUP BY p.id, p.owner_id
HAVING last_transaction_date IS NULL OR inactivity_days > 365
ORDER BY inactivity_days DESC;
