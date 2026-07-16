--Exploring the Customers Table
use role accountadmin;
use warehouse compute_wh;
use database analytics_db;
desc table raw_db.public.customers;
select * from raw_db.public.customers;

--Create the Customers Dynamic Table
create or replace dynamic table stg_customers_dt
    target_lag=downstream
    warehouse=compute_wh
    as select
        custid as customer_id,
        cname as customer_name,
        cast(spendlimit as float) as spend_limit
    from raw_db.public.customers;

--Explore the Orders Table
desc table raw_db.public.orders;
select * from raw_db.public.orders;

--Create the Orders Dynamic Table
create or replace dynamic table stg_orders_dt
   target_lag=downstream
   warehouse=compute_wh
   as select
       custid as customer_id,
       purchase:"prodid"::number(5) as product_id,
       purchase:"purchase_amount"::float(10) as order_price,
       purchase:"quantity"::number(5) as quantity,
       purchase:"purchase_date"::date as order_date
   from raw_db.public.orders;

-- Verify the Dynamic Tables
select * from analytics_db.public.stg_customers_dt;
select * from analytics_db.public.stg_orders_dt;

--View all Dynamic Tables and check the TARGET_LAG
show dynamic tables;