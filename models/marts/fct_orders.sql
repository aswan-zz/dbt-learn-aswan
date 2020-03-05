{{
  config(
    materialized='view'
  )
}}

with customers as (
    select * from {{ ref('stg_jaffle_shop_customers') }}
),
orders as (
    select * from {{ ref('stg_jaffle_shop_orders') }}
),
payments as (
    select * from {{ ref('stg_jaffle_shop_payments') }}
),
final as (
    select
        payments.order_id,
        customers.customer_id,
        sum(payments.amount) as amount
    from customers
    inner join orders using (customer_id)
    inner join payments using (order_id)
    group  by 1, 2
)
select * from final