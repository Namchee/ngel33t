# Write your MySQL query statement below
SELECT
    a.activity_date as day,
    COUNT(DISTINCT user_id) as 'active_users'
FROM
    Activity a
WHERE
    (activity_date > "2019-06-27" AND activity_date <= "2019-07-27")
GROUP BY
    a.activity_date
