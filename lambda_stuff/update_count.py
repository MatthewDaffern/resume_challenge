import boto3


def update_count(event, context):
    resource = boto3.resource('DynamoDB')
    table = resource.Table('counter')
    total_so_far = table.get_item(Key={'web_service': 'counter'})
    total_so_far_count = int(total_so_far['count']) + 1
    table.update_item(Key={'web_service': 'counter'},
                      UpdateExpression='SET age = :val1',
                      ExpressionAttributeValues={':val1': total_so_far_count})
    return table.get_item(Key={'web_service': 'counter'})
