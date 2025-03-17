CREATE TABLE stg_brands AS SELECT
    CAST(data->'_id'->>'$oid' AS VARCHAR(24)) AS brand_id,
    CAST(data->'cpg'->'$id'->>'$oid' AS VARCHAR(24)) AS cpg_oid,
	CAST(data->'cpg'->>'$ref' AS VARCHAR) AS cpg_ref,
	CAST(data->>'name' AS VARCHAR) AS name,
	CAST(data->>'barcode' AS VARCHAR(12)) AS barcode,
	CAST(data->>'topBrand' AS BOOLEAN) AS top_brand,
	CAST(data->>'brandCode' AS VARCHAR) AS brand_code,
	CAST(data->>'category' AS VARCHAR) AS category,
	CAST(data->>'categoryCode' AS VARCHAR) AS category_code
FROM brands_raw