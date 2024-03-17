SELECT
    player_id,
    MIN(event_date) as first_login
FROM
    activity
GROUP BY
    player_id
