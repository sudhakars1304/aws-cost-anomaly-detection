import json
import logging
import urllib3
import os

logging.basicConfig(level=logging.INFO)

def flattened_anomaly(json_data):
    return json_data

def post_to_webhook(data):
    try:
        http = urllib3.PoolManager()
        webhook_url = os.environ['IntegrationURL']
        headers = {'Content-Type': 'application/json'}
        encoded_data = json.dumps(data).encode('utf-8')
        logging.info(f"Sending payload to Jira: {json.dumps(data)}")
        response = http.request("POST", webhook_url, headers=headers, body=encoded_data)
        logging.info(f'Data posted to webhook, status: {response.status}')
        print(f"POST request has been posted. Status: {response.status}")
        print(f"Response body: {response.data.decode()}")
        if response.status not in [200, 201, 204]:
            logging.error(f'Webhook responded with error status: {response.status}, body: {response.data.decode()}')
    except Exception as e:
        logging.error(f'Failed to post data to webhook: {e}')

def lambda_handler(event, context):
    logging.info(event)
    try:
        for record in event['Records']:
            sns_message = record['Sns']['Message']
            if isinstance(sns_message, str):
                sns_message = json.loads(sns_message)
            flattened_data = flattened_anomaly(sns_message)
            post_to_webhook(flattened_data)
    except Exception as e:
        logging.error(f'Error processing SNS message: {e}')
        raise e
