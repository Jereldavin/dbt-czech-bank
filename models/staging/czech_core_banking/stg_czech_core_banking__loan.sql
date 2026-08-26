with 

source as (

    select * from {{ source('czech_core_banking', 'raw_loan') }}

),

renamed as (
    select
        cast(loan_id as varchar) as loan_id,
        cast(account_id as varchar) as account_id,
        to_date('19' || lpad(cast(date as varchar), 6, '0'), 'YYYYMMDD') as loan_granted_date,
        cast(amount as numeric(18,2)) as loan_amount,
        cast(duration as int) as duration_months,
        cast(payments as numeric(18,2)) as monthly_installment,
        case upper(trim(status))
            when 'A' then 'CONTRACT_FINISHED_PAID'
            when 'B' then 'CONTRACT_FINISHED_UNPAID_DEFAULT'
            when 'C' then 'RUNNING_CONTRACT_OK'
            when 'D' then 'RUNNING_CONTRACT_IN_DEBT'
            else 'UNKNOWN'
        end as loan_status
    from source
)
select * from renamed