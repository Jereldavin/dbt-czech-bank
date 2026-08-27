with districts as (
    select * from {{ ref('stg_czech_core_banking__district') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['district_id']) }} as district_key,
    district_id,
    district_name,
    region_name,
    population,
    urban_population_ratio,
    average_salary,
    unemployment_rate,
    total_crimes_committed
from districts