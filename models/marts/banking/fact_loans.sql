with loans as (
    select * from {{ ref('stg_czech_core_banking__loan') }}
),

client_accounts as (
    select * from {{ ref('int_client_account_relationships') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['l.loan_id']) }} as loan_key,
    l.loan_id,
    {{ dbt_utils.generate_surrogate_key(['l.account_id']) }} as account_key,
    {{ dbt_utils.generate_surrogate_key(['ca.client_id']) }} as customer_key,
    l.loan_granted_date,
    l.loan_amount,
    l.duration_months,
    l.monthly_installment,
    l.loan_status,
    case 
        when l.loan_status in ('CONTRACT_FINISHED_UNPAID_DEFAULT', 'RUNNING_CONTRACT_IN_DEBT') then true
        else false
    end as is_delinquent_flag
from loans l
left join client_accounts ca on l.account_id = ca.account_id