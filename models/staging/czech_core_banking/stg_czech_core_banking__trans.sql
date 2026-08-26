with 

source as (

    select * from {{ source('czech_core_banking', 'raw_trans') }}

),

renamed as (
    select
        cast(trans_id as varchar) as transaction_id,
        cast(account_id as varchar) as account_id,
        to_date('19' || lpad(cast(date as varchar), 6, '0'), 'YYYYMMDD') as transaction_date,
        case
            when upper(trim(type)) = 'PRIJEM' then 'CREDIT'
            when upper(trim(type)) = 'VYDAJ' then 'DEBIT'
            when upper(trim(type)) = 'VYBER' then 'WITHDRAWAL'
            else upper(trim(type))
        end as transaction_direction,
        coalesce(trim(operation), 'UNKNOWN') as operation_type,
        cast(amount as numeric(18,2)) as amount,
        cast(balance as numeric(18,2)) as balance_after_transaction,
        coalesce(trim(k_symbol), 'NONE') as payment_purpose_symbol,
        trim(bank) as partner_bank,
        trim(account) as partner_account
    from source
)
select * from renamed