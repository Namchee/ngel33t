# Write your MySQL query statement below
SELECT
    t.transaction_date,
    SUM(
        CASE
            WHEN amount % 2 = 1 THEN amount
            ELSE 0
        END
    ) AS odd_sum,
    SUM(
        CASE
            WHEN amount % 2 = 0 THEN amount
            ELSE 0
        END
    ) AS even_sum
FROM
    transactions t
GROUP BY
    t.transaction_date
ORDER BY
    t.transaction_date
