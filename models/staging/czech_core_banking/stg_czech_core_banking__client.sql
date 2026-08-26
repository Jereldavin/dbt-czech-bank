with 

source as (

    select * from {{ source('czech_core_banking', 'raw_client') }}

),

parsed as (
    select
        cast(client_id as varchar) as client_id,
        cast(district_id as varchar) as district_id,
        lpad(cast(birth_number as varchar), 6, '0') as raw_birth_num
    from source
),
transformed as (
    select
        client_id,
        district_id,
        case 
            when substring(raw_birth_num, 3, 2)::int > 50 then 'FEMALE'
            else 'MALE'
        end as gender,
        to_date(
            '19' || substring(raw_birth_num, 1, 2) || '-' ||
            lpad(case 
                when substring(raw_birth_num, 3, 2)::int > 50 
                then (substring(raw_birth_num, 3, 2)::int - 50)::varchar 
                else substring(raw_birth_num, 3, 2) 
            end, 2, '0') || '-' ||
            substring(raw_birth_num, 5, 2),
            'YYYY-MM-DD'
        ) as date_of_birth
    from parsed
)
select * from transformed