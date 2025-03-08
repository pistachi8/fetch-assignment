CREATE TABLE stg_users AS SELECT
    data->'_id'->>'$oid' AS id,
    data->>'active' AS active,
    data->'createdDate'->>'$date' AS created_date,
    data->'lastLogin'->>'$date' AS last_login,
    data->>'role' AS role,
    data->>'signUpSource' AS sign_up_source,
    data->>'state' AS state
FROM users_raw
