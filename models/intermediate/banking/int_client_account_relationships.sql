with accounts as (
    select * from {{ ref('stg_czech_core_banking__account') }}
),

clients as (
    select * from {{ ref('stg_czech_core_banking__client') }}
),

disp as (
    select * from {{ ref('stg_czech_core_banking__disp') }}
)

select
    d.disp_id,
    a.account_id,
    c.client_id,
    d.disposition_type,
    a.district_id as account_district_id,
    c.district_id as client_district_id,
    c.gender,
    c.date_of_birth,
    datediff('year', c.date_of_birth, a.account_opened_date) as client_age_at_account_open,
    a.statement_frequency,
    a.account_opened_date
from disp d
join accounts a on d.account_id = a.account_id
join clients c on d.client_id = c.client_id
where d.disposition_type = 'OWNER'