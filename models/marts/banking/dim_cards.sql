with cards as (
    select * from {{ ref('stg_czech_core_banking__card') }}
),

disp as (
    select * from {{ ref('stg_czech_core_banking__disp') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['c.card_id']) }} as card_key,
    c.card_id,
    {{ dbt_utils.generate_surrogate_key(['d.account_id']) }} as account_key,
    {{ dbt_utils.generate_surrogate_key(['d.client_id']) }} as customer_key,
    c.card_type,
    c.card_issued_date
from cards c
left join disp d on c.disp_id = d.disp_id