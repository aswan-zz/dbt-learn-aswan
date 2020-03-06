{%- set start_date = "to_date('01/01/2020', 'mm/dd/yyyy')" -%}

{{ dbt_utils.date_spine(
    datepart = "day",
    start_date = "to_date('01/01/2020', 'mm/dd/yyyy')",
    end_date = "dateadd(year, 1, to_date('01/01/2020', 'mm/dd/yyyy'))"
   )
}}