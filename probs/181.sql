SELECT
    a.name as 'Employee'
FROM
    Employee a INNER JOIN Employee b
    ON a.managerId = b.id
WHERE
    a.salary > b.salary
