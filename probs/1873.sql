SELECT
    employee_id,
    CASE
        WHEN REGEXP_LIKE(LOWER(name), '^[^m]') AND employee_id % 2 = 1 THEN salary
        ELSE 0
    END AS bonus
FROM
    Employees
ORDER BY
    employee_id
