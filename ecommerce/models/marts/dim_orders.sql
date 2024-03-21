WITH order_item_mesures AS (

	SELECT order_id,
		   SUM(item_sale_price) AS total_item_sale_price,
		   SUM(product_cost) AS total_product_cost,
		   SUM(item_profit) AS total_item_profit,
		   SUM(item_discount) AS total_item_discount

	FROM {{ref('inter_order_item_product')}}
	GROUP BY 1
)



SELECT o.order_id,
	   o.created_at AS order_created_at,
	   o.shipped_at AS order_shipped_at,
	   o.delivered_at AS order_delivered_at,
	   o.returned_at AS order_returned_at,
	   o.status AS order_status,
	   o.num_items_ordered,

	   o_i_m.total_item_sale_price,
	   o_i_m.total_product_cost,
	   o_i_m.total_item_profit,
	   o_i_m.total_item_discount,
	   TIMESTAMP_DIFF(o.created_at,fo.first_order_created, DAY) AS days_since_first_order

FROM {{ref('stg_orders')}} o
LEFT JOIN order_item_mesures o_i_m
ON o.order_id = o_i_m.order_id
LEFT JOIN {{ref('inter_first_order_created')}} fo
ON fo.user_id = o.user_id