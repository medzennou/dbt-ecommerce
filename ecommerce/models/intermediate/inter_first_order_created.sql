{{
  config(
	materialized = 'ephemeral'
	)
}}


SELECT  user_id , MIN(created_at) AS first_order_created
FROM {{ref('stg_orders')}}
GROUP BY 1