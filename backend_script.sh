#!/bin/bash


# S3 Portion
/usr/local/bin/aws s3api create-bucket --bucket mattssuperbucketdaffern --region us-east-1
/usr/local/bin/aws s3 cp . s3://mattssuperbucketdaffern/ --recursive;

# check if the stack exists or create it if so.
cd stack_configs;


stack_list=$(/usr/local/bin/aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE);


regex='^(DynamoDB|GetCount|UpdateCount)$'

if [[ $1 =~ $regex ]]; 
then
    /usr/local/bin/aws cloudformation update-stack --stack-name GetCount --template-body s3://mattssuperbucketdaffern/stack_configs/GetCount.json --region us-east-1;
    /usr/local/bin/aws cloudformation update-stack --stack-name DynamoDB --template-body s3://mattssuperbucketdaffern/stack_configs/DynamoDB.json --region us-east-1;
    /usr/local/bin/aws cloudformation update-stack --stack-name UpdateCount --template-body s3://mattssuperbucketdaffern/stack_configs/UpdateCount.json --region us-east-1;
else
    /usr/local/bin/aws cloudformation create-stack --stack-name GetCount --template-body s3://mattssuperbucketdaffern/stack_configs/GetCount.json --region us-east-1;
    /usr/local/bin/aws cloudformation create-stack --stack-name DynamoDB --template-body s3://mattssuperbucketdaffern/stack_configs/DynamoDB.json --region us-east-1;
    /usr/local/bin/aws cloudformation create-stack --stack-name UpdateCount --template-body s3://mattssuperbucketdaffern/stack_configs/UpdateCount.json --region us-east-1;
fi


cd ..;
# Invalidate the Cache

/usr/local/bin/aws cloudfront create-invalidation --distribution-id $(/usr/local/bin/aws cloudfront list-distributions --max-items 1) --paths *


