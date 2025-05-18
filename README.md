# DataAnalytics-Assessment
Data Analyst Role Assessment @ CowryWise 

## 1. High-Value Customers with Multiple Products
Goal: Find customers who have both funded savings and funded investment plans.

Approach:
I grouped and filtered savings and investment plans separately because each plan has its unique dynamic use patterns, then I used an INNER JOIN on the owner_id to find customers who appeared in both sets. I summed up their confirmed amounts to rank them by highest total deposits.

Challenge:
The tricky part was making sure in the query, customers had actual funded plans, so I used a condition like confirmed_amount > 0 to check. I also double checked to avoid double counting or missing any customer by using clear groupings.

## 2. Transaction Frequency Analysis
Goal: Categorize customers based on how frequently they transact each month (high, medium, or low).

Approach:
To solve this, I used Common Table Expressions (CTEs) to make the query easier to read and manage by breaking the logic into clear steps instead of writing everything in one long query. The first CTE (monthly_counts) calculates the number of transactions each customer makes per month. The second CTE (user_avg) then computes the average monthly transactions for each customer. I categorized customers based on this average into "High", "Medium", or "Low" frequency groups, and finally counted how many customers fall into each category.

Challenges:
The challenging part was ensuring I calculated monthly averages correctly per customer. I solved this by using two CTEs — one to count monthly transactions, and another to get the average per customer before applying the frequency labels.

## 3. Account Inactivity Alert
Goal: Identify savings or investment plans with no transactions in the past 365 days.

Approach:
Since I have two different tables - plans_plan and savings_savingsaccount, i used a join and filtered to include plans even if they have no transactions. I grouped by plan and owner to find the last transaction date, then calculated inactivity using DATEDIFF() and filtered for inactivity over one year.

Challenge:
I initially had trouble with the UNION ALL due to column mismatches. I fixed this by ensuring both queries selected the same column names and order

## 4. Customer Lifetime Value (CLV) Estimation
Goal: Estimate the value of each customer based on their account age and transaction volume.

Approach:
I calculated account tenure in months from the users_customuser.date_joined column, counted all their transactions in the savings_savingsplan, and estimated CLV using the formula provided:
CLV = (total_transactions / tenure_months) * 12 * (0.001 * avg_transaction_value)

Challenge:
Clarifying the 0.1% profit rate meant converting it properly to 0.001 in the calculation. I also ensured that tenure was at least 1 to avoid dividing by zero.


