SELECT
    user_id,
    COUNT(follower_id) AS followers_count
FROM
    Followers
WHERE
    user_id != follower_id  -- This removes self-follows immediately
GROUP BY
    user_id
ORDER BY
    user_id;
