select
    vend_name,
    (
        select count(product_number)
        from product_vendors
        join products using (product_number)
        where product_vendors.vendor_id = vendors.vendor_id
    ) as products
from
    vendors;
