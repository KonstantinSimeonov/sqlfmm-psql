select
    product_name,
    case when orders is null then 0 else orders end
from (
    select
        product_name,
        sum(quantity_ordered) as orders
    from products
    left join order_details using (product_number)
    group by product_number, product_name
) as orders
order by orders, product_name;
