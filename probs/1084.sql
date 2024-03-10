SELECT
    p.product_id,
    product_name
FROM
    product p INNER JOIN sales s
    ON p.product_id = s.product_id

WHERE
    s.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
GROUP BY
    s.product_id
