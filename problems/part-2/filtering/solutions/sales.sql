\c sales_orders_example;
SELECT
    vend_name
FROM
    vendors
WHERE
    vend_city IN ('Ballard', 'Bellevue', 'Redmond');

SELECT
    product_name,
    retail_price
FROM
    products
WHERE
    retail_price >= 125
ORDER BY
    product_name;

SELECT
    vend_name
FROM
    vendors
WHERE
    vend_web_page IS NULL;
