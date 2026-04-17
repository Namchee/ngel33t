# Write your MySQL query statement below
SELECT
    DATE_FORMAT(t.trans_date,'%Y-%m') AS 'month',
    country,
    COUNT(id) AS trans_count,
    COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM
    Transactions t
GROUP BY
    YEAR(t.trans_date),
    MONTH(t.trans_date),
    country
