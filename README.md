# fetch-assignment

PART ONE

Based on some exploratory analysis, I created a diagram with 5 entities: Users, Receipts, Receipt Items, Brands, and Metabrite Items. Each entity can be identified by a unique primary key as noted in the diagram which can be found at /ER Diagram/ER Diagram.png. To help identify the fields provided in the json files, I created two python functions extract_columns_from_jsonl and extract_keys which can be found at /source_data/parse_json.py.

I then created raw tables to load the json data into using the Postgres copy command. From there I staged the data, explicitly casting fields into the appropriate data types.

The raw tables live at /analytics/data_model/load_data and the staged data lives at /analytics/data_model.

Some notes on improvements to the ER Diagram:
The Receipt Items entity can likely be broken out into smaller entities to reduce redundancy. For example, certain fields such as target_price and item_number seem to be functionally dependent on just the item (identified by the barcode) whereas other fields are functionally dependent on multiple fields such as quantity purchased on item barcode and receipt id. This suggests to me that we should be able to create another entity called Item that stores item level information identified by the item barcode. However, without further information about the fields it's difficult to determine based on the data alone whether these fields are truly functionally dependent on the item barcode only or if it just appears so with the current data that I can see. I would want to better understand the fields before making a decision either way.



------------------------------------------------------
PART TWO

To help write the queries that answer the 6 questions posed by the stakeholder, I created a reporting layer on top of my main data model to easily grab the information I need to answer common business questions without needing to join multiple tables each time.

The reporting_layer model is defined in /analytics/queries/reporting_layer.sql and the queries to answer the 6 questions are defined in /analytics/queries/part_two_queries.sql.



------------------------------------------------------
PART THREE

I used SQL tests to check data quality. Most of these tests can be streamlined using a tool such as dbt. Otherwise, we can manually test for them as well.

The data quality checks I did fall into one of the following categories:
1. A unique and not null test on all primary keys across all staging tables, except for stg_receipt_items as I manually generated the primary keys for that table so there should be no issues.
2. I checked for null values on all fields across all tables. This is not to say that all fields should not be null. It is probably okay that some fields are null such as price_after_coupon in stg_receipt_items. We are just trying to get a sense of how many missing values there are. Once we know this, we can discuss with stakeholders whether it's okay if these fields are null, if there is "true" missing data, or if we should coalesce certain fields -- for example, if top_brand is null in stg_brands, we could coalesce it to False.
3. A relationship test among fields across tables where we would expect a relationship as defined in the ER Diagram -- I only created this test for relationships between tables where the tables don't come from the same source.
4. Tests to confirm that the total spent and total quantity of items purchase are equivalent between the receipt and the receipt item list.
5. While I did not implement this test, we should discuss with stakeholders whether there exists certain fields who's value should belong to a list of predetermined values. For example, is there a predetermined list of categories under which all brands should fall under?

These data quality tests live in /analytics/data_quality/data_quality.sql



------------------------------------------------------
PART FOUR

The email I constructed for stakeholders is located at stakeholder_communication.md.