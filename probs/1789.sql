# Write your MySQL query statement below
WITH EmployeeWithMulti AS (
    SELECT
        employee_id,
        department_id
    FROM
        Employee e
    WHERE
        primary_flag = 'Y'
), EmployeeWithSingle AS (
    SELECT
        employee_id,
        department_id
    FROM
        Employee e
    GROUP BY
        employee_id
    HAVING
        COUNT(department_id) = 1
)

SELECT
    *
FROM
    EmployeeWithMulti
UNION
    SELECT
        *
    FROM
        EmployeeWithSingle
