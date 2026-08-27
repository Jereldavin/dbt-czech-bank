with accounts as (
    select * from {{ ref('stg_czech_core_banking__account') }}
),
districts as (
    select * from {{ ref('stg_czech_core_banking__district') }}
)
select
    {{ dbt_utils.generate_surrogate_key(['a.account_id']) }} as account_key,
    a.account_id,
    a.district_id,
    d.district_name,
    d.region_name,
    a.statement_frequency,
    a.account_opened_date
from accounts a
left join districts d on a.district_id = d.district_id