{{ config(schema='staging') }}

select
    id as payment_id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    (amount/100) as amount,
    created as created_at
from {{ source('stripe', 'payment') }}
