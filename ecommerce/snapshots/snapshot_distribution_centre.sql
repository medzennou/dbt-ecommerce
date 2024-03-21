{% snapshot snapshot__distribution_centre %}


{{
   config(
	   target_database='dbt-ecommerce-416311',
	   target_schema='dbt_test_snapshot',
	   unique_key='id',

	   strategy='check',
	   check_cols=['name','latitude','longitude']
   )
}}

SELECT * FROM {{ source('thelook_ecommerce', 'distribution_centers') }}

{% endsnapshot %}