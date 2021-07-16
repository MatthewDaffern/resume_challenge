import boto3


def get_count(event, context):
    resource = boto3.resource('DynamoDB')
    table = resource.Table('counter')
    return table.get_item(Key={'web_service': 'counter'})
