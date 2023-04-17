/*
What plan start_date values occur after the year 2020 for our dataset?
Show the breakdown by count of events for each plan_name
*/

SELECT plan_id, COUNT(customer_id) AS total_subscriptions
FROM foodie_fi.subscriptions
WHERE start_date > '2020-01-01'
GROUP BY plan_id
ORDER BY total_subscriptions DESC
