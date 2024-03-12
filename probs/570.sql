SELECT
    a.name
FROM
    employee a INNER JOIN employee b
    ON a.id = b.managerId
GROUP BY
    a.id
HAVING
    COUNT(a.id) >= 5;
