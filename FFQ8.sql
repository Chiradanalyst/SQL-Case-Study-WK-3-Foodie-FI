/*
How many customers have upgraded to an annual plan in 2020?
*/

WITH next_plan_cte AS(
    SELECT *, 
        LEAD(plan_id, 1) 
        OVER(PARTITION BY customer_id ORDER BY start_date) as next_plan
    FROM foodie_fi.subscriptions
)
SELECT COUNT(DISTINCT(customer_id))
FROM next_plan_cte
WHERE next_plan=3 AND EXTRACT(YEAR FROM start_date) = '2020'