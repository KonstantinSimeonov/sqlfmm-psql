select
    vend_name,
    count(product_number),
    string_agg(product_name, ', ')
from vendors
left join product_vendors using (vendor_id)
left join products using (product_number)
where product_name is not null
group by vendor_id, vend_name;
