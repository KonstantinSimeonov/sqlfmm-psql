select
    avg(ship_date - order_date),
    vend_name,
    vendor_id
from
    vendors
left join product_vendors using (vendor_id)
left join products using (product_number)
left join order_details using (product_number)
left join orders using (order_number)
group by vendor_id, vend_name;
