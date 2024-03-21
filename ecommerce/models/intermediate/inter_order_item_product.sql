WITH products AS (

	SELECT product_id,
	       department AS product_departement,
		   cost AS product_cost,
		   retail_price AS product_retail_price

	FROM {{ref('stg_products')}}
)

SELECT o_i.order_item_id,
	   o_i.order_id,
	   o_i.user_id,
	   o_i.product_id,

	   o_i.item_sale_price,

	   p.product_departement,
	   p.product_cost,
	   p.product_retail_price,

	   o_i.item_sale_price - p.product_cost AS item_profit,
	   p.product_retail_price - o_i.item_sale_price AS item_discount

FROM {{ ref('stg_orders_items') }} AS o_i
LEFT JOIN products p
ON p.product_id = o_i.product_id