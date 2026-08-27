{{ config(
    materialized='incremental',
    unique_key='transaction_pk',
    incremental_strategy='merge'
) }}

with enriched_txns as (
    select * from {{ ref('int_transactions_enriched') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['transaction_id']) }} as transaction_pk,
    transaction_id,
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key,
    {{ dbt_utils.generate_surrogate_key(['client_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['district_id']) }} as district_key,
    transaction_date,
    transaction_direction,
    operation_type,
    signed_amount,
    absolute_amount,
    balance_after_transaction,
    payment_purpose_symbol,
    partner_bank
from enriched_txns

{% if is_incremental() %}
  where transaction_date >= (select max(transaction_date) from {{ this }})
{% endif %}