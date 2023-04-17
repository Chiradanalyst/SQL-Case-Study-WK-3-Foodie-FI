/*

How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

*/
WITH next_plan_cte AS(
    SELECT *, 
        LEAD(plan_id, 1) 
        OVER(PARTITION BY customer_id ORDER BY start_date) as next_plan
    FROM foodie_fi.subscriptions
)
SELECT COUNT(*) AS customers_downgraded
FROM next_plan_cte
WHERE plan_id=2 AND next_plan=1;