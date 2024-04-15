SELECT
    product_name,
    year,
    price
FROM sales s
    INNER JOIN product p
    ON s.product_id = p.product_id;
