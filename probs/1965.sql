# Write your MySQL query statement below
WITH EmployeeWithNoSalary AS (
    SELECT
        employee_id
    FROM
        Employees e
    WHERE
        employee_id NOT IN (
            SELECT
                employee_id
            FROM
                Salaries
        )
), SalaryWithNoEmployee AS (
    SELECT
        employee_id
    FROM
        Salaries s
    WHERE
        employee_id NOT IN (
            SELECT
                employee_id
            FROM
                Employees
        )
)

SELECT
    *
FROM
    EmployeeWithNoSalary
UNION
    SELECT
        *
    FROM
        SalaryWithNoEmployee
ORDER BY
    employee_id
