CREATE TABLE receipt_items_raw AS
SELECT
    CAST(data->'_id'->>'$oid' AS VARCHAR(24)) AS receipt_id,
    jsonb_array_elements(data->'rewardsReceiptItemList') AS receipt_items
FROM receipts_raw;