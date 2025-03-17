CREATE TABLE stg_users AS
SELECT DISTINCT
    CAST(data->'_id'->>'$oid' AS VARCHAR(24)) AS user_id,
    CAST(data->>'active' AS BOOLEAN) AS active,
    TO_TIMESTAMP(CAST(data->'createdDate'->>'$date' AS NUMERIC) / 1000) AS created_date,
    TO_TIMESTAMP(CAST(data->'lastLogin'->>'$date' AS NUMERIC) / 1000) AS last_login,
    CAST(data->>'role' AS VARCHAR) AS role,
    CAST(data->>'signUpSource' AS VARCHAR) AS sign_up_source,
    CAST(data->>'state' AS VARCHAR(2)) AS state
FROM users_raw
