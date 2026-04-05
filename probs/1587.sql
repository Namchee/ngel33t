SELECT
    u.name AS name,
    SUM(amount) AS balance
FROM
    Users u INNER JOIN Transactions t
    ON u.account = t.account
GROUP BY
    u.account
HAVING
    balance > 10000;
