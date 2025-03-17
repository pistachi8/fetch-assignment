/*
The queries below answer all 6 questions posed by business stakeholders. They are broken up into 3 general themes of questions: top brands,
receipt status, and brand data based on user creation date.

All queries draw from the reporting_layer model which is defined in /analytics/queries/reporting_layer.sql
*/

/*
-------------
Top Brands
-------------
Brand information is missing for many receipt items as we're not able to match the item barcode to barcodes in the brands table. This is likely a
data quality issue where the data in brands.json is incomplete. Due to this, no conclusion can be made for the top 5 brands for the most recent month
as brand info for all receipts scanned during that time is null. Similarly, we're unable to make a conclusion or compare top 5 brands for the most recent 2 months. 
*/

-- What are the top 5 brands by receipts scanned for most recent month?
SELECT
        brand_name,
        month_year,
        count(receipt_id) AS receipts_scanned
    FROM reporting_layer
    WHERE month_rank = 1
    GROUP BY 1, 2
    ORDER BY receipts_scanned DESC
    LIMIT 5;

-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
WITH current_top_five_brands AS (
    SELECT
        brand_name,
        month_year,
        COUNT(receipt_id) AS receipts_scanned
    FROM reporting_layer
    WHERE month_rank = 1
    GROUP BY 1, 2
    ORDER BY receipts_scanned DESC
    LIMIT 5
),
prev_top_five_brands AS (
    SELECT
        brand_name,
        month_year,
        COUNT(receipt_id) AS receipts_scanned
    FROM reporting_layer
    WHERE month_rank = 2
    GROUP BY 1, 2
    ORDER BY receipts_scanned DESC
    LIMIT 5
)

SELECT *
FROM current_top_five_brands
UNION ALL
SELECT *
FROM prev_top_five_brands

/*
--------------
Receipt Status
--------------
Here we assume that a receipt with status of "Finished" has been rejected -- otherwise the status would be
"Pending" if still being processed, "Rejected" if rejected, or "Flagged" if further review is needed.

There appeared to be some data quality issues here as well which may have some affect on the final answer.
Total spent on the receipt did not always match up with the sum of the final price of items on the receipt.
Similarly, purchased item count on the receipt did not always match up with the sum of items * purchase quantity of each item on the receipt.
For simplicity, we went with the receipt level totals and item quantity.
*/

-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- Average spend for "Accepted" receipts is greater at $1246.78 per receipt, than average spend for "Rejected" receipts at $19.90 per receipt.
SELECT
    rewards_receipt_status,
    ROUND(AVG(CAST(total_spent AS NUMERIC)), 2) AS total_spent
FROM reporting_layer
GROUP BY 1;

-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- Total number of items purchased is greater for "Accepted" receipts (total of 1,368,106 items) than for "Rejected" receipts (total of 740 items).
SELECT
    rewards_receipt_status,
    SUM(purchased_item_count) AS items_purchased
FROM reporting_layer
GROUP BY 1;

/*
--------------------------------------
Brand Data Based On User Creation Date
--------------------------------------
There were additional data quality issues that we came across when running analysis on users.
There were duplicates in the source data provided which we were able to deduplicate.
However, there are receipts associated with user id's that we don't have information for.
The users.json file we received is likely incomplete.

Since there were no users created in the last 6 months, the answers to both questions posed below will be none.
If we wanted to know which brand has the most spend or number of transactions among users over all time, we can
delete the first filter condition that looks at the amount of time that has passed between today and user creation
date from both queries.

The answer to which brand has the total spend among users over all time would be Pepperidge Farm with a total spend of $23,298.19.
And the answer to which brand has the most transactions among users over all time, assuming that one receipt represents one transaction,
is Tostitos with 23 transactions total.
*/

-- Which brand has the most spend among users who were created within the past 6 months?
SELECT
    brand_name,
    SUM(CAST(total_spent AS numeric)) AS total_spend
FROM reporting_layer
WHERE EXTRACT(DAY FROM CURRENT_DATE - user_created_date) < 183
AND brand_name IS NOT null
GROUP BY 1
ORDER BY total_spend DESC
LIMIT 1;

-- Which brand has the most transactions among users who were created within the past 6 months?
SELECT
    brand_name,
    COUNT(receipt_id) AS num_transactions
FROM reporting_layer
WHERE EXTRACT(DAY FROM CURRENT_DATE - user_created_date) < 183
AND brand_name IS NOT null
GROUP BY 1
ORDER BY num_transactions DESC
LIMIT 1;