# INNER JOIN

### Example 1
- List all customers who have ordered both a bike and a helmet

```sql
SELECT
    cust_first_name || ' ' || cust_last_name AS customer
FROM (
    SELECT
        customer_id
    FROM
        orders
        JOIN (
            SELECT
                (CASE WHEN product_name LIKE '%bike' THEN 1 ELSE 0 END) AS bikes,
                (CASE WHEN product_name LIKE '%helmet' THEN 1 ELSE 0 END) AS helmets,
                product_name,
                order_number
            FROM
                order_details
                JOIN (
                    SELECT
                        *
                    FROM
                        products
                    WHERE
                        product_name LIKE '%helmet'
                        OR product_name LIKE '%bike'
                    ) AS ps USING (product_number)
            ) AS odp USING (order_number)
            GROUP BY
                customer_id
            HAVING
                sum(bikes) > 0
                AND sum(helmets) > 0
    ) AS cids
JOIN
    customers USING (customer_id)
ORDER BY
    customer;
```
