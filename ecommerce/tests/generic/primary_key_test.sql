{% test primary_key(model, column_name) %}

WITH validation AS (

SELECT {{column_name}} AS primary_key,
		COUNT(1) AS occurence
FROM {{model}}

GROUP BY 1

)

SELECT *
FROM validation
WHERE primary_key IS NULL OR occurence > 1

{% endtest %}

{# Another test
{% test greather_than_value(model,column_name,value=0) %}

SELECT {{column_name}} AS column_failed
FROM {{model}}
WHERE  {{column_name}}  <= {{value}}

{% endtest%}

 #}
