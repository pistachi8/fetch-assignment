
/*
Data Quality Checks for Metabrite Items
*/

-- Each original_metabrite_barcode should be unique and not null in the stg_metabrite_items table.
-- The result of the query below gives us the number of records in stg_metabrite_items that are either missing the original_metabrite_barcode or where original_metabrite_barcode has a duplicate.
WITH metabrite AS (
    SELECT
        original_metabrite_barcode,
        count(*) AS count
    FROM stg_metabrite_items
    GROUP BY 1
)

SELECT *
FROM metabrite
WHERE original_metabrite_barcode IS null
OR count > 1;

-- Counting missing values in stg_metabrite_items not including original_metabrite_barcode which was already checked for
SELECT
    SUM(CASE WHEN original_metabrite_description IS NULL THEN 1 ELSE 0 END) as original_metabrite_description,
    SUM(CASE WHEN original_metabrite_item_price IS NULL THEN 1 ELSE 0 END) as original_metabrite_item_price,
    SUM(CASE WHEN original_metabrite_quantity_purchased IS NULL THEN 1 ELSE 0 END) as original_metabrite_quantity_purchased
FROM stg_metabrite_items;
