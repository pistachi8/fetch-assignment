CREATE TABLE stg_receipts AS
SELECT
    CAST(data->'_id'->>'$oid' AS VARCHAR(24)) AS receipt_id,
    CAST(data->>'bonusPointsEarned' AS INTEGER) AS bonus_points_earned,
    CAST(data->>'bonusPointsEarnedReason' AS VARCHAR) AS bonus_points_earned_reason,
    TO_TIMESTAMP(CAST(data->'createDate'->>'$date' AS NUMERIC) / 1000) AS create_date,
    TO_TIMESTAMP(CAST(data->'dateScanned'->>'$date' AS NUMERIC) / 1000) AS date_scanned,
    TO_TIMESTAMP(CAST(data->'finishedDate'->>'$date' AS NUMERIC) / 1000) AS finished_date,
    TO_TIMESTAMP(CAST(data->'modifyDate'->>'$date' AS NUMERIC) / 1000) AS modify_date,
    TO_TIMESTAMP(CAST(data->'pointsAwardedDate'->>'$date' AS NUMERIC) / 1000) AS points_awarded_date,
    CAST(CAST(data->>'pointsEarned' AS FLOAT) AS INTEGER) AS points_earned,
    TO_TIMESTAMP(CAST(data->'purchaseDate'->>'$date' AS NUMERIC) / 1000) AS purchase_date,
    CAST(data->>'purchasedItemCount' AS INTEGER) AS purchased_item_count,
    CAST(data->>'rewardsReceiptStatus' AS VARCHAR) AS rewards_receipt_status,
    CAST(data->>'totalSpent' AS MONEY) AS total_spent,
    CAST(data->>'userId' AS VARCHAR(24)) AS user_id
FROM receipts_raw;
