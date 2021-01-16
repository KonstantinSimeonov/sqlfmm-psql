select
    ent_stage_name,
    engagement_count
from (
    select
        entertainer_id,
        count(*) as engagement_count
    from
        engagements
    group by entertainer_id
) as c
join entertainers using (entertainer_id);
