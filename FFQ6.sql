/*

What is the number and percentage of customer plans after their initial free trial?

*/

WITH count_plans AS (
	SELECT COUNT(customer_id) as customer_plans, plan_id
	FROM foodie_fi.subscriptions
	GROUP BY plan_id),
	next_plan_cte AS(
    SELECT *, 
       LEAD(plan_id, 1) 
       OVER(PARTITION BY customer_id ORDER BY start_date) as next_plan
    FROM foodie_fi.subscriptions
),
conversions AS (
    SELECT next_plan, COUNT(*) AS total_conversions
    FROM next_plan_cte
    WHERE next_plan IS NOT NULL AND plan_id = 0
    GROUP BY next_plan
    ORDER BY next_plan
)
SELECT count_plans.plan_id, total_conversions, customer_plans,
        ROUND(CAST(total_conversions::FLOAT / customer_plans::FLOAT * 100 AS NUMERIC), 2) AS percent_directly_converted
FROM count_plans JOIN conversions
    ON count_plans.plan_id = conversions.next_plan;
