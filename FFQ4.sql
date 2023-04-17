/*

What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

*/
DROP TABLE IF EXISTS total_count;
CREATE TEMP TABLE total_count AS (
    SELECT COUNT(DISTINCT customer_id) AS num
    FROM foodie_fi.subscriptions
);
WITH churn_count as (
SELECT COUNT(distinct(customer_id)) AS total_churn_count, plan_id
FROM foodie_fi.subscriptions
WHERE plan_id = 4
group by plan_id)
SELECT churn_count.total_churn_count AS num_churned,
       churn_count.total_churn_count::FLOAT  / total_count.num::FLOAT *100 AS percent_churned
FROM churn_count, total_count;

