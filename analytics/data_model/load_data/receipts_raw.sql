CREATE TABLE receipts_raw (
    id SERIAL PRIMARY KEY,
    data JSONB
);

/* psql command to load data from json file
\copy receipts_raw(data) FROM 'source_data/receipts.json'
May need to edit escaped characters in the source file for the above to run properly (i.e.: from \ to \\)
*/