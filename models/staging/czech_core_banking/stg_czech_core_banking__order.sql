with 

source as (

    select * from {{ source('czech_core_banking', 'raw_order') }}

),

renamed as (
    select
        cast(order_id as varchar) as order_id,
        cast(account_id as varchar) as account_id,
        trim(bank_to) as recipient_bank,
        trim(account_to) as recipient_account,
        cast(amount as numeric(18,2)) as payment_amount,
        trim(k_symbol) as order_purpose
    from source
)
select * from renamed