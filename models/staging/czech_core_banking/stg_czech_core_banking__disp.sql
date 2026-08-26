with 

source as (

    select * from {{ source('czech_core_banking', 'raw_disp') }}

),

renamed as (
    select
        cast(disp_id as varchar) as disp_id,
        cast(client_id as varchar) as client_id,
        cast(account_id as varchar) as account_id,
        upper(trim(type)) as disposition_type -- OWNER or DISPONENT
    from source
)
select * from renamed