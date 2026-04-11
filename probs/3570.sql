SELECT
    l.book_id,
    l.title,
    l.author,
    l.genre,
    l.publication_year,
    l.total_copies AS current_borrowers
FROM
    library_books l INNER JOIN borrowing_records r
    ON l.book_id = r.book_id
WHERE
    r.return_date IS NULL
GROUP BY
    l.book_id
HAVING
    COUNT(record_id) = l.total_copies
ORDER BY
    current_borrowers DESC,
    l.title
