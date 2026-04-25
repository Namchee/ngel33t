# Write your MySQL query statement below
SELECT
    ro.customer_id,
    COUNT(ro.order_id) AS total_orders,
    ROUND(SUM(
        CASE
            WHEN (TIME(order_timestamp) >= '11:00:00' AND TIME(order_timestamp) <= '14:00:00') OR (TIME(order_timestamp) >= '18:00:00' AND TIME(order_timestamp) <= '21:00:00') THEN 1
        END
    ) / COUNT(ro.order_id) * 100, 0) AS peak_hour_percentage,
    ROUND(SUM(order_rating) / SUM(CASE WHEN order_rating IS NOT NULL THEN 1 END), 2) AS average_rating
FROM
    restaurant_orders ro
GROUP BY
    customer_id
HAVING
    total_orders > 2  AND
    peak_hour_percentage >= 60 AND
    SUM(
        CASE
            WHEN order_rating IS NOT NULL THEN 1
        END
    ) / COUNT(ro.order_id) >= 0.5 AND
    average_rating >= 4.0
ORDER BY
    average_rating DESC,
    ro.customer_id DESC
