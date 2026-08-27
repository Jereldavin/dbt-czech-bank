with txns as (
    select * from {{ ref('int_transactions_enriched') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['account_id', 'transaction_date']) }} as daily_balance_key,
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key,
    {{ dbt_utils.generate_surrogate_key(['client_id']) }} as customer_key,
    transaction_date as balance_date,
    sum(signed_amount) as daily_net_change,
    count(transaction_id) as total_daily_transactions,
    max(balance_after_transaction) as end_of_day_balance
from txns
group by 1, 2, 3, 4