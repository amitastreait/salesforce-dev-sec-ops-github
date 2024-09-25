import jwt
import time
import requests
import json
import argparse

# Function to authenticate using JWT Bearer Token flow
def jwt_authenticate(client_id, user_email, private_key, login_url='https://login.salesforce.com'):
    header = {
        "alg": "RS256",
        "typ": "JWT"
    }

    claims = {
        "iss": client_id,                      
        "sub": user_email,                     
        "aud": login_url,                      
        "exp": int(time.time()) + 300          
    }

    encoded_jwt = jwt.encode(claims, private_key, algorithm='RS256', headers=header)

    token_endpoint = f"{login_url}/services/oauth2/token"
    response = requests.post(token_endpoint, data={
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': encoded_jwt
    })

    if response.status_code != 200:
        raise Exception(f"JWT authentication failed: {response.text}")
    
    token_data = response.json()
    access_token = token_data['access_token']
    instance_url = token_data['instance_url']
    return access_token, instance_url

# Function to insert Salesforce records
def insert_record(access_token, instance_url, sobject, data):
    url = f"{instance_url}/services/data/v57.0/sobjects/{sobject}/"
    headers = {
        'Authorization': f"Bearer {access_token}",
        'Content-Type': 'application/json'
    }
    response = requests.post(url, headers=headers, data=json.dumps(data))
    
    if response.status_code == 201:
        return response.json()['id']
    else:
        raise Exception(f"Failed to insert {sobject} record: {response.text}")

# Main function to handle the process
def import_data(client_id, user_email, private_key, data_file):
    access_token, instance_url = jwt_authenticate(client_id, user_email, private_key)

    with open(data_file, 'r') as file:
        data = json.load(file)
        for record in data:
            insert_record(access_token, instance_url, record['sobject'], record['fields'])

# Argument parsing
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Import Salesforce data using JWT authentication.')
    
    parser.add_argument('--client_id', required=True, help='Salesforce Connected App Client ID')
    parser.add_argument('--user_email', required=True, help='Salesforce user email for authentication')
    parser.add_argument('--private_key', required=True, help='Path to the RSA private key file')
    parser.add_argument('--data_file', required=True, help='Path to the JSON file containing data to be imported')

    args = parser.parse_args()
    print(args.client_id)
    # Read private key from the file
    with open(args.private_key, 'r') as key_file:
        private_key = key_file.read()

    # Call the import data function
    import_data(args.client_id, args.user_email, private_key, args.data_file)

# python IMPORT_SFDC_DATA.py  --client_id "client_id" --user_email "user_email" --private_key "private_key" --data_file "data_to_import.json"