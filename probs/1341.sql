# Write your MySQL query statement below
WITH UserWithMostRatings AS (
    SELECT
        u.name AS results
    FROM
        Users u INNER JOIN MovieRating m
        ON u.user_id = m.user_id
    GROUP BY
        u.user_id
    ORDER BY
        COUNT(m.movie_id) DESC,
        u.name
    LIMIT
        1
), MovieWithHighestRatings AS (
    SELECT
        m.title AS results
    FROM
        Movies m INNER JOIN MovieRating r
        ON m.movie_id = r.movie_id
    WHERE
        r.created_at >= '2020-02-01' AND r.created_at < '2020-03-01'
    GROUP BY
        m.movie_id
    ORDER BY
        ROUND(SUM(r.rating) / COUNT(r.rating), 2) DESC,
        m.title
    LIMIT
        1
)

SELECT
    *
FROM
    UserWithMostRatings
UNION ALL
SELECT
    *
FROM
    MovieWithHighestRatings m
