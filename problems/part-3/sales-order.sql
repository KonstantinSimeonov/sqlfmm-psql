-- 1
SELECT
    cust_first_name || ' ' || cust_last_name as customer,
    order_date
FROM
    customers
    JOIN orders USING (customer_id)
ORDER BY
    order_date;

-- 2
SELECT DISTINCT
    emp_first_name || ' ' || emp_last_name as employee,
    customer
FROM
    employees
    JOIN (
        SELECT
            cust_first_name || ' ' || cust_last_name as customer,
            employee_id
        FROM
            customers
            JOIN orders USING (customer_id)
    ) AS co USING (employee_id);

-- 4
SELECT
    vend_name,
    product_name,
    wholesale_price
FROM (
    SELECT
        *
    FROM
        vendors
        JOIN product_vendors USING (vendor_id)
    ) AS v
JOIN
    products
USING (product_number)
WHERE
    wholesale_price < 100;

-- 5
SELECT
    cust_first_name || ' ' || cust_last_name as customer,
    emp_first_name || ' ' || emp_last_name as employee
FROM
    customers
    JOIN employees ON cust_last_name = emp_last_name;

-- 6
SELECT
    cust_first_name || ' ' || cust_last_name as customer,
    emp_first_name || ' ' || emp_last_name as employee,
    emp_city as city
FROM
    customers
    JOIN employees ON cust_city = emp_city;
