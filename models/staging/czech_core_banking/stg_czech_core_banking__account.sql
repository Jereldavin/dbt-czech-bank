with 

source as (

    select * from {{ source('czech_core_banking', 'raw_account') }}

),

renamed as (

    select
        account_id,
        district_id,
        frequency,
        date

    from source

)

select * from renamed