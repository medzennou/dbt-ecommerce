{#
{{
  config(
	severity = 'warn',
	)
}}

WITH order_item AS (

	SELECT order_id,
		   COUNT(*) AS num_items_in_order
	FROM {{ref('stg_orders_items')}}
)

SELECT
FROM {{ref('stg_orders')}} AS o
FULL OUTER JOIN order_item o_it USING(order_id)
WHERE o.order_id IS NULL OR o_it.order_id IS NULL OR o.num_items_ordered != o_it.num_items_in_order
#}
