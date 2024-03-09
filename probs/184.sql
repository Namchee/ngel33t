SELECT
    Department.name as 'Department',
    Employee.name as 'Employee',
    Employee.salary as 'Salary'
FROM
    Department LEFT JOIN Employee
    ON Department.id = Employee.departmentId
WHERE
    (departmentId, salary) IN (SELECT departmentId, MAX(salary) FROM Employee GROUP BY departmentId)
