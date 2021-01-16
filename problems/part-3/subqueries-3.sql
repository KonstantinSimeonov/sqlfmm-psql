select
    *
from
    products
where product_number not in (
    select product_number from order_details
);
