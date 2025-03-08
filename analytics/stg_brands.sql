CREATE TABLE stg_brands AS SELECT
    data->'_id'->>'$oid' AS id,
    data->'cpg'->'$id'->>'$oid' AS cpg_oid,
	data->'cpg'->>'$ref' AS ref,
	data->'name' AS name,
	data->'barcode' AS barcode,
	data->'topBrand' AS top_brand,
	data->'brandCode' AS brand_code,
	data->'category' AS category,
	data->'categoryCode' AS category_code
FROM brands_raw