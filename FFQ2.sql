/*
What is the monthly distribution of trial plan start_date values for our dataset
- use the start of the month as the group by value
*/

SELECT EXTRACT(MONTH FROM start_date) AS month_number, COUNT(*) as customers
FROM foodie_fi.subscriptions
WHERE plan_id = 0
GROUP BY month_number
ORDER BY month_number;