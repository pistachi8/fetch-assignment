CREATE TABLE stg_receipt_items AS
SELECT
    receipt_id,
    CAST(receipt_items->>'barcode' AS VARCHAR(12)) AS barcode,
    CAST(receipt_items->>'brandCode' AS VARCHAR) AS brand_code,
    CAST(receipt_items->>'competitiveProduct' AS BOOLEAN) AS competitive_product,
    CAST(receipt_items->>'competitorRewardsGroup' AS VARCHAR) AS competitor_rewards_group,
    CAST(receipt_items->>'deleted' AS BOOLEAN) AS deleted,
    CAST(receipt_items->>'description' AS VARCHAR) AS description,
    CAST(receipt_items->>'discountedItemPrice' AS MONEY) AS discounted_item_price,
    CAST(receipt_items->>'finalPrice' AS MONEY) AS final_price,
    CAST(receipt_items->>'itemNumber' AS NUMERIC(12)) AS item_number,
    CAST(receipt_items->>'itemPrice' AS MONEY) AS item_price,
    CAST(receipt_items->>'metabriteCampaignId' AS VARCHAR) AS metabrite_campaign_id,
    CAST(receipt_items->>'needsFetchReview' AS BOOLEAN) AS needs_fetch_review,
    CAST(receipt_items->>'needsFetchReviewReason' AS VARCHAR) AS needs_fetch_review_reason,
    CAST(receipt_items->>'originalFinalPrice' AS MONEY) AS original_final_price,
    CAST(NULLIF(receipt_items->>'originalMetaBriteBarcode', '') AS VARCHAR(12)) AS original_metabrite_barcode,
    CAST(receipt_items->>'originalReceiptItemText' AS VARCHAR) AS original_receipt_item_text,
    CAST(receipt_items->>'priceAfterCoupon' AS MONEY) AS price_after_coupon,
    CAST(CAST(receipt_items->>'partnerItemId' AS FLOAT) AS INTEGER) AS partner_item_id,
    CAST(CAST(receipt_items->>'pointsEarned' AS FLOAT) AS INTEGER) AS points_earned,
    CAST(receipt_items->>'pointsNotAwardedReason' AS VARCHAR) AS points_not_awarded_reason,
    CAST(receipt_items->>'pointsPayerId' AS VARCHAR(24)) AS points_payer_id,
    CAST(receipt_items->>'preventTargetGapPoints' AS BOOLEAN) AS prevent_target_gap_points,
    CAST(receipt_items->>'quantityPurchased' AS INTEGER) AS quantity_purchased,
    CAST(receipt_items->>'rewardsGroup' AS VARCHAR) AS rewards_group,
    CAST(receipt_items->>'rewardsProductPartnerId' AS VARCHAR(24)) AS rewards_product_partner_id,
    CAST(receipt_items->>'targetPrice' AS MONEY) AS target_price,
    CAST(NULLIF(receipt_items->>'userFlaggedBarcode','') AS VARCHAR(12)) AS user_flagged_barcode,
    CAST(receipt_items->>'userFlaggedDescription' AS VARCHAR) AS user_flagged_description,
    CAST(receipt_items->>'userFlaggedNewItem' AS BOOLEAN) AS user_flagged_new_item,
    CAST(receipt_items->>'userFlaggedPrice' AS MONEY) AS user_flagged_price,
    CAST(receipt_items->>'userFlaggedQuantity' AS INTEGER) AS user_flagged_quantity
FROM receipt_items_raw;

-- Adding a serial type column to the table as there are no natural primary keys. (The combination of receipt_id and barcode is not unique.)
ALTER TABLE stg_receipt_items ADD COLUMN receipt_item_id SERIAL;