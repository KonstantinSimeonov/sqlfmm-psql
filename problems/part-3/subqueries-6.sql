select
    *
from
    agents
where
    agent_id not in (
        select agent_id from engagements
    );
