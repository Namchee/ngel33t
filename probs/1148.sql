SELECT
    author_id as id
FROM views
WHERE author_id = viewer_id
GROUP BY author_id
ORDER BY author_id;
