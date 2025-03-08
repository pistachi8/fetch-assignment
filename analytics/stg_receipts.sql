CREATE TABLE stg_receipts AS
SELECT
    data->'_id'->>'$oid' AS id,
    data->>'bonusPointsEarned' AS bonus_points_earned,
    data->>'bonusPointsEarnedReason' AS bonus_points_earned_reason,
    data->'createDate'->>'$date' AS create_date,
    data->'dateScanned'->>'$date' AS date_scanned,
    data->'finishedDate'->>'$date' AS finished_date,
    data->'modifyDate'->>'$date' AS modify_date,
    data->'pointsAwardedDate'->>'$date' AS points_awarded_date,
    data->>'pointsEarned' AS points_earned,
    data->'purchaseDate'->>'$date' AS purchase_date,
    data->>'purchasedItemCount' AS purchased_item_count,
    data->'rewardsReceiptItemList' AS receipt_items,
    data->>'rewardsReceiptStatus' AS rewards_receipt_status,
    data->>'totalSpent' AS total_spent,
    data->>'userId' AS user_id
FROM receipts_raw;
