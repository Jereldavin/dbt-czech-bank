with client_accounts as (
    select * from {{ ref('int_client_account_relationships') }}
),

districts as (
    select * from {{ ref('stg_czech_core_banking__district') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['ca.client_id']) }} as customer_key,
    ca.client_id as customer_id,
    ca.gender,
    ca.date_of_birth,
    datediff('year', ca.date_of_birth, current_date()) as current_age,
    ca.client_district_id as district_id,
    d.district_name,
    d.region_name,
    d.average_salary as district_avg_salary
from client_accounts ca
left join districts d on ca.client_district_id = d.district_id