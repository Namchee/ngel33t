# Write your MySQL query statement below
SELECT
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN COUNT(CASE WHEN u.id IS NOT NULL THEN 1 END) > 0 THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM
    Tree t LEFT JOIN Tree u
    ON t.id = u.p_id
GROUP BY
    t.id
