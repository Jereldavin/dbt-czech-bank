with 

source as (

    select * from {{ source('czech_core_banking', 'raw_card') }}

),

renamed as (
    select
        cast(card_id as varchar) as card_id,
        cast(disp_id as varchar) as disp_id,
        upper(trim(type)) as card_type, -- JUNIOR, CLASSIC, GOLD
        to_date('19' || lpad(cast(issued as varchar), 6, '0'), 'YYYYMMDD') as card_issued_date
    from source
)
select * from renamed