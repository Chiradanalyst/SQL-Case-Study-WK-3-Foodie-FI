/*
What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

*/

WITH next_date_cte AS (
    SELECT *,
            LEAD (start_date, 1) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_date
    FROM foodie_fi.subscriptions
),
customers_on_date_cte AS (
    SELECT plan_id, COUNT(DISTINCT customer_id) AS customers
    FROM next_date_cte
    WHERE (next_date IS NOT NULL AND ('2020-12-31'::DATE > start_date AND '2020-12-31'::DATE < next_date))
        OR (next_date IS NULL AND '2020-12-31'::DATE > start_date)
    GROUP BY plan_id
),
total_count AS (
    SELECT COUNT(DISTINCT customer_id) AS num
    FROM foodie_fi.subscriptions)

SELECT plan_id, customers, ROUND(CAST(customers::FLOAT / num::FLOAT * 100 AS NUMERIC), 2) AS percentage
FROM customers_on_date_cte, total_count