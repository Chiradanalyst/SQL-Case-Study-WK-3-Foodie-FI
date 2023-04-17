/*

How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

*/

WITH join_date AS (
    SELECT customer_id, start_date 
    FROM foodie_fi.subscriptions 
    WHERE plan_id = 0
),
pro_date AS (
    SELECT customer_id, start_date AS upgrade_date 
    FROM foodie_fi.subscriptions 
    WHERE plan_id = 3
)

SELECT ROUND(AVG(upgrade_date - start_date), 2) AS avg_days_to_upgrade
FROM join_date JOIN pro_date
    ON join_date.customer_id = pro_date.customer_id;