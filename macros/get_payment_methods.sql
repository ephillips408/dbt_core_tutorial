{# Allows us to dynamically retrieve the list of payment methods #}

{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
select distinct
{{ column_name }}
from {{ relation }}
order by 1
{% endset %}

{% set results = run_query(relation_query) %}

{# From the tutorial #}
{# We used the execute variable to ensure that the code runs during the parse stage of dbt (otherwise an error would be thrown) #}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{  return(results_list) }}

{% endmacro %}

{% macro get_payment_methods() %}

{{ return(get_column_values('payment_method', ref('raw_payments'))) }}

{% endmacro %}