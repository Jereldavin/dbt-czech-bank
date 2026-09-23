# Czech Banking Data Modeling

Data modelling project where i apply kimball star schema to the PKDD'99 Czech banking dataset

## Overview
The pipeline processes highly normalized, legacy transactional data into a reliable reporting model focusing on customer behavior, account activity, and loan delinquency.
## Architecture & Technical Decisions
* **Staging**: 1:1 views of raw data. Handles type casting, renaming, and parsing legacy date strings.
* **Intermediate**: Ephemeral models resolving many-to-many fan-outs (e.g., mapping clients to accounts via disposition types).
* **Marts**: A Kimball star schema (`dim_customers`, `dim_accounts`, `fact_transactions`, `fact_loans`).
* **Keys**: Implemented MD5 surrogate keys via `dbt_utils.generate_surrogate_key` for reliable joins.
* **Testing**: Strict enforcement of `unique`, `not_null`, `accepted_values`, and `relationships` (referential integrity) tests across the pipeline.
