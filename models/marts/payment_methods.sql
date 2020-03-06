{%- set payment_method_sql -%}
    select distinct payment_method from {{ref("stg_stripe_payments")}}
{%- endset -%}

{%- if execute -%}
    {%- set results = run_query(payment_method_sql) -%}
    {%- set payment_methods = results.columns[0].values() -%}
{%- endif -%}

with payments as (
    select * from {{ref("stg_stripe_payments")}}
),

pivoted as (
    select  
            order_id,
            {% for payment_method in payment_methods -%}
            sum(case when payment_method = '{{ payment_method }}' then amount end) as "{{ payment_method }}"{%-
                if not loop.last -%},{%- endif %}
            {% endfor %}
    from payments
    group by 1
)

select * from pivoted