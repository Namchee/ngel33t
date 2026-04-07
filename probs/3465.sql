# Write your MySQL query statement below
SELECT
    *
FROM
    products
WHERE
    REGEXP_LIKE(description, '\\bSN\\d{4}-\\d{4}\\b', 'c')
ORDER BY
    product_id
