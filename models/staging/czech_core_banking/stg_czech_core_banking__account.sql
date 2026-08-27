with 

source as (

    select * from {{ source('czech_core_banking', 'raw_account') }}

),

renamed as (

    select
        cast (account_id as varchar) as account_id,
        cast (district_id as varchar) as district_id,
        trim(frequency) as statement_frequency,
        to_date('19' || lpad(cast(date as varchar), 6, '0'), 'YYYYMMDD') as account_opened_date
    from source
)
select * from renamed

   