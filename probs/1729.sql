SELECT
    a.user_id,
    COUNT(a.follower_id) AS followers_count
FROM
    Followers a INNER JOIN Followers b
    ON a.user_id != b.follower_id AND a.user_id = b.user_id AND a.follower_id = b.follower_id
GROUP BY
    a.user_id
ORDER BY
    a.user_id
