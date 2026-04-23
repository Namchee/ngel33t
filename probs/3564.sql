# Write your MySQL query statement below
WITH Winter AS (
    SELECT
        'Winter' AS season,
        category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM
        sales s INNER JOIN products p
        ON s.product_id = p.product_id
    WHERE
        MONTH(sale_date) IN (12, 1, 2)
    GROUP BY
        p.category
    ORDER BY
        total_quantity DESC,
        total_revenue DESC
    LIMIT
        1
), Fall AS (
    SELECT
        'Fall' AS season,
        category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM
        sales s INNER JOIN products p
        ON s.product_id = p.product_id
    WHERE
        MONTH(sale_date) IN (9, 10, 11)
    GROUP BY
        p.category
    ORDER BY
        total_quantity DESC,
        total_revenue DESC
    LIMIT
        1
), Spring AS (
    SELECT
        'Spring' AS season,
        category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM
        sales s INNER JOIN products p
        ON s.product_id = p.product_id
    WHERE
        MONTH(sale_date) IN (3, 4, 5)
    GROUP BY
        p.category
    ORDER BY
        total_quantity DESC,
        total_revenue DESC
    LIMIT
        1
), Summer AS (
    SELECT
        'Summer' AS season,
        category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM
        sales s INNER JOIN products p
        ON s.product_id = p.product_id
    WHERE
        MONTH(sale_date) IN (6, 7, 8)
    GROUP BY
        p.category
    ORDER BY
        total_quantity DESC,
        total_revenue DESC
    LIMIT
        1
)

SELECT
    *
FROM
    Fall
UNION ALL
SELECT
    *
FROM
    Spring
UNION ALL
SELECT
    *
FROM
    Summer
UNION ALL
SELECT
    *
FROM
    Winter
