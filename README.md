# **Project Title**: Automated ELT Pipeline with dbt, Airflow, and Snowflake

Description: 
An end-to-end ELT pipeline that loads raw TPC-H order data into Snowflake, transforms it through a layered dbt project (staging → intermediate → marts), and orchestrates the whole workflow on an automated schedule using Apache Airflow and Astronomer Cosmos.

## Overview

This project simulates a real-world analytics engineering workflow:

- **Extract & Load**: Raw TPC-H data (orders, line items, customers, etc.) into Snowflake
- **Transform**: A dbt project restructures raw tables into clean, tested, analytics-ready models using the standard **staging → intermediate → marts** layering pattern
- **Orchestrate**: Apache Airflow, via the Cosmos provider, turns the dbt DAG into native Airflow tasks and runs the full pipeline automatically on a recurring schedule
- **Test & Validate**: dbt's built-in and custom generic tests (`unique`, `not_null`, `relationships`, `accepted_values`) guard data quality at each layer

## Architecture

```
┌─────────────┐      ┌─────────────────────────────┐      ┌──────────────┐
│   Raw TPC-H │ ───▶ │           dbt models         │ ───▶ │   Snowflake  │
│   seed data │      │  staging → intermediate →    │      │  (analytics- │
└─────────────┘      │           marts              │      │  ready data) │
                      └──────────────┬───────────────┘      └──────────────┘
                                     │
                      ┌──────────────▼───────────────┐
                      │   Apache Airflow + Cosmos     │
                      │  (schedules & orchestrates    │
                      │   the dbt DAG every 30 min)   │
                      └────────────────────────────────┘
```

## Tech Stack

| Layer | Tool |
|---|---|
| Data Warehouse | [Snowflake](https://www.snowflake.com/) |
| Transformation | [dbt Core](https://www.getdbt.com/) (`dbt-snowflake`) |
| Orchestration | [Apache Airflow](https://airflow.apache.org/) |
| dbt ↔ Airflow bridge | [Astronomer Cosmos](https://github.com/astronomer/astronomer-cosmos/) |
| Local dev environment | [Astro CLI](https://www.astronomer.io/docs/astro/cli/overview) |
| Sample dataset | TPC-H benchmark data 

<img src="https://github.com/Yam-ghub/dbt_project/blob/main/img/image.jpg" alt="Airflow" width="1200">



