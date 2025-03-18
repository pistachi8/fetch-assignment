DROP TABLE brands_raw;
CREATE TABLE brands_raw (
    id SERIAL PRIMARY KEY,
    data JSONB
);

/* psql command to load data from json file
\copy brands_raw(data) FROM 'source_data/brands.json'
May need to edit escaped characters in the source file for the above to run properly (i.e.: from \ to \\)
*/