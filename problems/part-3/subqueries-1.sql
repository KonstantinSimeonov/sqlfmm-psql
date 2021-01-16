select
    product_name,
    max(order_date)
from
    orders
join
    order_details using (order_number)
join
    products using (product_number)
group by
    product_name;
