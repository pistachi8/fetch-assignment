/*
Data Quality Checks for Users
*/

-- Each user_id should be unique and not null in the stg_users table.
-- This query's result set is empty because I have already deduplicated records in stg_users. However, the users.json file did originally contain duplicates.
WITH users AS (
    SELECT
        user_id,
        count(*) AS count
    FROM stg_users
    GROUP BY 1
)

SELECT *
FROM users
WHERE user_id IS null
OR count > 1;

-- For each user_id associated with a receipt in stg_receipts, there should exist the same user_id in the stg_users table.
-- The result of the query below gives us the user_ids that are missing from the users.json file.
SELECT
    user_id
FROM stg_receipts
WHERE user_id NOT IN (SELECT user_id FROM stg_users);

-- Counting missing values in stg_users not including user_id which was already checked for
SELECT
    SUM(CASE WHEN active IS NULL THEN 1 ELSE 0 END) as active,
    SUM(CASE WHEN created_date IS NULL THEN 1 ELSE 0 END) as created_date,
    SUM(CASE WHEN last_login IS NULL THEN 1 ELSE 0 END) as last_login,
    SUM(CASE WHEN role IS NULL THEN 1 ELSE 0 END) as role,
    SUM(CASE WHEN sign_up_source IS NULL THEN 1 ELSE 0 END) as sign_up_source,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) as state
FROM stg_users;
