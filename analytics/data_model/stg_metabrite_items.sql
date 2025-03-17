CREATE TABLE stg_metabrite_items AS
SELECT DISTINCT
    CAST(NULLIF(receipt_items->>'originalMetaBriteBarcode', '') AS VARCHAR(12)) AS original_metabrite_barcode,
    CAST(receipt_items->>'originalMetaBriteDescription' AS VARCHAR) AS original_metabrite_description,
    CAST(receipt_items->>'originalMetaBriteItemPrice' AS MONEY) AS original_metabrite_item_price,
    CAST(receipt_items->>'originalMetaBriteQuantityPurchased' AS INTEGER) AS original_metabrite_quantity_purchased
FROM receipt_items_raw;
