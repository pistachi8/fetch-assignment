/*
Data Quality Checks for Receipts and Receipt Items
*/

-- Each receipt_id should be unique and not null in the stg_receipts table.
WITH receipts AS (
    SELECT
        receipt_id,
        count(*) AS count
    FROM stg_receipts
    GROUP BY 1
)

SELECT *
FROM receipts
WHERE receipt_id IS null
OR count > 1;

-- We would expect the total_spent amount on a receipt to be equivalent to the sum of final_price * quantity_purchased for all items that are listed on a receipt.
-- The result of the query below gives us the receipt_id of all receipts where the above is not true.
SELECT
    r.receipt_id,
    r.total_spent,
    SUM(i.final_price * i.quantity_purchased) AS items_total_spent_recipt_list
FROM stg_receipts AS r
INNER JOIN stg_receipt_items AS i
    ON r.receipt_id = i.receipt_id
GROUP BY 1, 2
HAVING r.total_spent != SUM(i.final_price * i.quantity_purchased);

-- We would expect the purchased_item_count on a receipt to be equivalent to the sum of quantity_purchased for all items that are listed on a receipt.
-- The result of the query below gives us the receipt_id of all receipts where the above is not true.
SELECT
    r.receipt_id,
    r.purchased_item_count,
    SUM(i.quantity_purchased) AS items_purchased_receipt_list
FROM stg_receipts AS r
INNER JOIN stg_receipt_items AS i
    ON r.receipt_id = i.receipt_id
GROUP BY 1, 2
HAVING r.purchased_item_count != SUM(i.quantity_purchased);

-- Counting missing values in stg_receipts, not including receipt_id which was already checked for
SELECT
    SUM(CASE WHEN bonus_points_earned IS NULL THEN 1 ELSE 0 END) as bonus_points_earned,
    SUM(CASE WHEN bonus_points_earned_reason IS NULL THEN 1 ELSE 0 END) as bonus_points_earned_reason,
    SUM(CASE WHEN create_date IS NULL THEN 1 ELSE 0 END) as create_date,
    SUM(CASE WHEN date_scanned IS NULL THEN 1 ELSE 0 END) as date_scanned,
    SUM(CASE WHEN finished_date IS NULL THEN 1 ELSE 0 END) as finished_date,
    SUM(CASE WHEN modify_date IS NULL THEN 1 ELSE 0 END) as modify_date,
    SUM(CASE WHEN points_awarded_date IS NULL THEN 1 ELSE 0 END) as points_awarded_date,
    SUM(CASE WHEN points_earned IS NULL THEN 1 ELSE 0 END) as points_earned,
    SUM(CASE WHEN purchase_date IS NULL THEN 1 ELSE 0 END) as purchase_date,
    SUM(CASE WHEN purchased_item_count IS NULL THEN 1 ELSE 0 END) as purchased_item_count,
    SUM(CASE WHEN rewards_receipt_status IS NULL THEN 1 ELSE 0 END) as rewards_receipt_status,
    SUM(CASE WHEN total_spent IS NULL THEN 1 ELSE 0 END) as total_spent,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) as user_id
FROM stg_receipts;

-- Counting missing values in stg_receipt_items
SELECT
    SUM(CASE WHEN barcode IS NULL THEN 1 ELSE 0 END) as barcode,
    SUM(CASE WHEN brand_code IS NULL THEN 1 ELSE 0 END) as brand_code,
    SUM(CASE WHEN competitive_product IS NULL THEN 1 ELSE 0 END) as competitive_product,
    SUM(CASE WHEN competitor_rewards_group IS NULL THEN 1 ELSE 0 END) as competitor_rewards_group,
    SUM(CASE WHEN deleted IS NULL THEN 1 ELSE 0 END) as deleted,
    SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) as description,
    SUM(CASE WHEN discounted_item_price IS NULL THEN 1 ELSE 0 END) as discounted_item_price,
    SUM(CASE WHEN final_price IS NULL THEN 1 ELSE 0 END) as final_price,
    SUM(CASE WHEN item_number IS NULL THEN 1 ELSE 0 END) as item_number,
    SUM(CASE WHEN item_price IS NULL THEN 1 ELSE 0 END) as item_price,
    SUM(CASE WHEN metabrite_campaign_id IS NULL THEN 1 ELSE 0 END) as metabrite_campaign_id,
    SUM(CASE WHEN needs_fetch_review IS NULL THEN 1 ELSE 0 END) as needs_fetch_review,
    SUM(CASE WHEN needs_fetch_review_reason IS NULL THEN 1 ELSE 0 END) as needs_fetch_review_reason,
    SUM(CASE WHEN original_final_price IS NULL THEN 1 ELSE 0 END) as original_final_price,
    SUM(CASE WHEN original_metabrite_barcode IS NULL THEN 1 ELSE 0 END) as original_metabrite_barcode,
    SUM(CASE WHEN original_receipt_item_text IS NULL THEN 1 ELSE 0 END) as original_receipt_item_text,
    SUM(CASE WHEN price_after_coupon IS NULL THEN 1 ELSE 0 END) as price_after_coupon,
    SUM(CASE WHEN partner_item_id IS NULL THEN 1 ELSE 0 END) as partner_item_id,
    SUM(CASE WHEN points_earned IS NULL THEN 1 ELSE 0 END) as points_earned,
    SUM(CASE WHEN points_not_awarded_reason IS NULL THEN 1 ELSE 0 END) as points_not_awarded_reason,
    SUM(CASE WHEN points_payer_id IS NULL THEN 1 ELSE 0 END) as points_payer_id,
    SUM(CASE WHEN prevent_target_gap_points IS NULL THEN 1 ELSE 0 END) as prevent_target_gap_points,
    SUM(CASE WHEN quantity_purchased IS NULL THEN 1 ELSE 0 END) as quantity_purchased,
    SUM(CASE WHEN rewards_group IS NULL THEN 1 ELSE 0 END) as rewards_group,
    SUM(CASE WHEN rewards_product_partner_id IS NULL THEN 1 ELSE 0 END) as rewards_product_partner_id,
    SUM(CASE WHEN target_price IS NULL THEN 1 ELSE 0 END) as target_price,
    SUM(CASE WHEN user_flagged_barcode IS NULL THEN 1 ELSE 0 END) as user_flagged_barcode,
    SUM(CASE WHEN user_flagged_description IS NULL THEN 1 ELSE 0 END) as user_flagged_description,
    SUM(CASE WHEN user_flagged_new_item IS NULL THEN 1 ELSE 0 END) as user_flagged_new_item,
    SUM(CASE WHEN user_flagged_price IS NULL THEN 1 ELSE 0 END) as user_flagged_price,
    SUM(CASE WHEN user_flagged_quantity IS NULL THEN 1 ELSE 0 END) as user_flagged_quantity
FROM stg_receipt_items;
