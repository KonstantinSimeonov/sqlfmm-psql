select
    *
from
    entertainers
where
    entertainer_id in (
        select
            entertainer_id
        from
            engagements
        join customers
        on
            engagements.customer_id = customers.customer_id
            and cust_last_name in ('Berg', 'Hallmark')
    );
