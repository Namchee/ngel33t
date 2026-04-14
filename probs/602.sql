WITH Accepter AS (
    SELECT
        accepter_id AS id,
        COUNT(requester_id) as acc
    FROM
        RequestAccepted r
    GROUP BY
        accepter_id
), Requester AS (
    SELECT
        requester_id AS id,
        COUNT(accepter_id) AS req
    FROM
        RequestAccepted r
    GROUP BY
        requester_id
)

SELECT
    COALESCE(a.id, r.id) AS id,
    COALESCE(acc, 0) + COALESCE(req, 0) AS num
FROM
    Accepter a FULL OUTER JOIN Requester r
    ON a.id = r.id
ORDER BY
    num DESC
LIMIT
    1
