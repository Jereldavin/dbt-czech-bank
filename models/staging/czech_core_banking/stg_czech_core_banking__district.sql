with 

source as (

    select * from {{ source('czech_core_banking', 'raw_district') }}

),

renamed as (
    select
        cast(district_id as varchar) as district_id,
        trim(district_name) as district_name,
        trim(region) as region_name,
        cast(no_of_inhabitants as int) as population,
        cast(ratio_of_urban_inhabitants as numeric(5,2)) as urban_population_ratio,
        cast(average_salary as numeric(12,2)) as average_salary,
        cast(unemployment_rate_96 as numeric(5,2)) as unemployment_rate,
        cast(no_of_commited_crimes_96 as int) as total_crimes_committed
    from source
)
select * from renamed