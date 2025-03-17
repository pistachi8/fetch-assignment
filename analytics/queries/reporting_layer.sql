DROP TABLE IF EXISTS reporting_layer;

-- In this table, I gathered and calculated all fields necessary to answer all 5 questions posed in the second part of the exercise
CREATE TABLE reporting_layer AS
WITH receipt_item_brand_user AS (
    SELECT
        usr.user_id,
        usr.created_date AS user_created_date,
        item.receipt_id,
        item.barcode AS item_barcode,
		DATE_TRUNC('month', receipt.date_scanned) AS month_year,
        receipt.purchased_item_count,
        receipt.rewards_receipt_status,
        receipt.total_spent,
        brand.name AS brand_name
    FROM stg_receipt_items AS item
    INNER JOIN stg_receipts AS receipt
        ON item.receipt_id = receipt.receipt_id
    LEFT JOIN stg_users AS usr
        ON receipt.user_id = usr.user_id
    LEFT JOIN stg_brands AS brand
        ON item.barcode = brand.barcode
)

SELECT
    *,
    DENSE_RANK() OVER (ORDER BY month_year DESC) AS month_rank
FROM receipt_item_brand_user;