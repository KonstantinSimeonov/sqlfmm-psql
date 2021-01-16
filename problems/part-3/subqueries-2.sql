select
    *
from
    customers
where customer_id in (
    select
        customer_id
    from
        orders
    join order_details using (order_number)
    join products using (product_number)
    where category_id = 2
);
