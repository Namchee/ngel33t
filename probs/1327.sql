WITH TargetOrders AS (
    SELECT
        o.product_id,
        o.unit
    FROM
        Orders o
    WHERE
        o.order_date >= '2020-02-01' AND o.order_date <= '2020-02-29'
)

SELECT
    p.product_name,
    SUM(ta.unit) AS unit
FROM
    Products p INNER JOIN TargetOrders ta
    ON p.product_id = ta.product_id
GROUP BY
    p.product_id
HAVING
    SUM(ta.unit) >= 100;
