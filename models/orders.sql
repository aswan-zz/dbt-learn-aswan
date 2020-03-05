{{
  config(
    materialized='view'
  )
}}

with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
payments as (
    select * from {{ ref('stg_payments') }}
),
final as (
    select
        payments.order_id,
        customers.customer_id,
        sum(payments.amount) as amount
    from customers
    left join orders using (customer_id)
    left join payments using (order_id)
    group  by 1, 2
)
select * from final