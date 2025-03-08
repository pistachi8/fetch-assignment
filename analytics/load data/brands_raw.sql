CREATE TABLE brands_raw (
    id SERIAL PRIMARY KEY,
    data JSONB
);

/* psql command to load data from json file
\copy brands(data) FROM '/Users/helenali/Desktop/brands.json'
*/