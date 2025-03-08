CREATE TABLE users_raw (
    id SERIAL PRIMARY KEY,
    data JSONB
);

/* psql command to load data from json file
\copy users(data) FROM '/Users/helenali/Desktop/users.json'
*/