with txns as (
    select * from {{ ref('stg_czech_core_banking__trans') }}
),

client_accounts as (
    select * from {{ ref('int_client_account_relationships') }}
)

select
    t.transaction_id,
    t.account_id,
    ca.client_id,
    ca.account_district_id as district_id,
    t.transaction_date,
    t.transaction_direction,
    t.operation_type,
    case
        when t.transaction_direction in ('DEBIT', 'WITHDRAWAL') then -1 * abs(t.amount)
        else abs(t.amount)
    end as signed_amount,
    t.amount as absolute_amount,
    t.balance_after_transaction,
    t.payment_purpose_symbol,
    t.partner_bank
from txns t
left join client_accounts ca on t.account_id = ca.account_id