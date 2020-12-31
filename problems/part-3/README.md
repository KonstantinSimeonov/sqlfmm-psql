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

## Practice problems

#### Sales orders database
1. List customers and the dates they places an order, sorted in order date sequence (944 rows, 2 tables join)
1. List employees and customers for whom they booked an order (211 rows, more than 2 tables join)
1. Display all orders, the products in each order, and the amount owed for each product, in order number sequence (3973 rows, more than 2 tables join)
1. Show me the vendors and products they supply to us for products that cost less than $100 (66 rows, more than 2 tables join)
1. Show me customers and employees who have the same last name (16 rows, 2 tables join)
1. Show me customers and employees living in the same cities (10 rows, 2 tables join)
