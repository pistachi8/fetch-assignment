CREATE TABLE receipts_raw (
    id SERIAL PRIMARY KEY,
    data JSONB
);

/* psql command to load data from json file
\copy receipts(data) FROM '/Users/helenali/Desktop/receipts.json'
*/