SELECT
    DISTINCT p.user_id,
    q.prompt_count,
    q.avg_tokens
FROM
    prompts p INNER JOIN (
        SELECT
            user_id,
            COUNT(prompt) AS prompt_count,
            ROUND(SUM(tokens) / COUNT(prompt), 2) AS avg_tokens
        FROM
            prompts
        GROUP BY
            user_id
        HAVING
            COUNT(prompt) >= 3
    ) q ON p.user_id = q.user_id
WHERE
    p.tokens > q.avg_tokens
ORDER BY
    q.avg_tokens DESC,
    p.user_id
