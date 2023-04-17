/*

Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

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
),
bins AS (
    SELECT WIDTH_BUCKET(upgrade_date - start_date, 0, 360, 12) AS avg_days_to_upgrade
    FROM join_date JOIN pro_date
        ON join_date.customer_id = pro_date.customer_id
)


SELECT ((avg_days_to_upgrade - 1)*30 || '-' || (avg_days_to_upgrade)*30) AS "30-day-range", COUNT(*)
FROM bins
GROUP BY avg_days_to_upgrade
ORDER BY avg_days_to_upgrade;