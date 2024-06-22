SELECT
    d.name as Department,
    e.name as Employee,
    e.salary as Salary
FROM
    employee e INNER JOIN department d
    ON e.departmentId = d.id
WHERE
    salary IN (
        SELECT
            DISTINCT(salary)
        FROM
            employee ee
        WHERE
            ee.departmentId = d.id
        ORDER BY    
            salary DESC
        LIMIT
            3
    )
