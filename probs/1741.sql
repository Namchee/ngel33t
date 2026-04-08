SELECT
    event_day as day,
    e.emp_id,
    SUM(out_time - in_time) AS total_time
FROM
    Employees e
GROUP BY
    event_day,
    emp_id
