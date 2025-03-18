import json

# Functions to grab the keys (what will become the columns of our staging tables) from provided newline-delimited JSON files

# Recursively extract keys from JSON object
def extract_keys(json_obj, parent_key='', keys=None):
    if keys is None:
        keys = []
    
    if isinstance(json_obj, dict):  # If the json_obj is a key-value pair
        for key, val in json_obj.items():
            if isinstance(val, dict):
                if parent_key != '':
                    new_key = f"{parent_key}->{key}"
                else:
                    new_key = key
            elif parent_key != '':
                new_key = f"{parent_key}->>{key}"
                keys.append(new_key)
            else:
                new_key = key
                keys.append(new_key)
            extract_keys(val, new_key, keys)

    elif isinstance(json_obj, list):  # If json_obj is a list of json objects
        for obj in json_obj:
            extract_keys(obj, parent_key, keys)

    return keys



# Function to process a newline-delimited JSON file and extract columns
def extract_columns_from_jsonl(input_file):
    columns = set()
    with open(input_file, 'r') as infile:
        for line in infile:
            try:
                json_object = json.loads(line.strip())
            except json.JSONDecodeError as e:
                print(line.strip())
            
            # Extract the column names from the JSON object and deduplicate using a set
            columns.update(extract_keys(json_object))

    return columns

#NOTE: May need to edit escaped characters in the source file for the below to run properly (i.e.: from \\ to \)
#columns = extract_columns_from_jsonl('/Users/helenali/Desktop/fetch-assignment/data/receipts.json')
#columns = extract_columns_from_jsonl('/Users/helenali/Desktop/fetch-assignment/data/users.json')
columns = extract_columns_from_jsonl('/Users/helenali/Desktop/fetch-assignment/data/brands.json')
for col in sorted(columns):
    print(col)
