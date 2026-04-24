# Write your MySQL query statement below
SELECT
    customer_id
FROM
    customer_transactions
GROUP BY
    customer_id
HAVING
    COUNT(CASE WHEN transaction_type = 'purchase' THEN 1 END) >= 3 AND
    DATEDIFF(MAX(transaction_date), MIN(transaction_date)) > 29 AND
    COUNT(CASE WHEN transaction_type = 'refund' THEN 1 END) / COUNT(transaction_id) < 0.2
ORDER BY
    customer_id
