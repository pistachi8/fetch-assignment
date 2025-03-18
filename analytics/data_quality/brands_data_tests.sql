/*
Data Quality Checks for Brands
*/

-- Each brand_id should be unique and not null in the stg_brands table.
WITH brands AS (
    SELECT
        brand_id,
        count(*) AS count
    FROM stg_brands
    GROUP BY 1
)

SELECT *
FROM brands
WHERE brand_id IS null
OR count > 1;

-- For each item barcode that exists in stg_receipt_items, there should exist a corresponding record in the stg_brands table containing brand information for that item.
-- The result of the query below gives us the item barcodes that are missing from the brands.json file.
SELECT DISTINCT
    barcode
FROM stg_receipt_items
WHERE barcode NOT IN (SELECT barcode FROM stg_brands);

-- Counting missing values in stg_brands not including brand_id which was already checked for
SELECT
    SUM(CASE WHEN cpg_oid IS NULL THEN 1 ELSE 0 END) as cpg_oid,
    SUM(CASE WHEN cpg_ref IS NULL THEN 1 ELSE 0 END) as cpg_ref,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) as name,
    SUM(CASE WHEN barcode IS NULL THEN 1 ELSE 0 END) as barcode,
    SUM(CASE WHEN top_brand IS NULL THEN 1 ELSE 0 END) as top_brand,
    SUM(CASE WHEN brand_code IS NULL THEN 1 ELSE 0 END) as brand_code,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) as category
FROM stg_brands;
