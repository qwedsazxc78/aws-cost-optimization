#!/bin/bash

# this will list all buckets in the account
# adapt this script to filter the list according to your needs
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text); do
:
# exclude opening and closing brackets
if [ $bucket = "[" ] || [ $bucket = "]" ]; then
  continue
fi

# remove double quotes and commas
bucket=$(echo "$bucket" | sed 's/"//g' | sed 's/,//g')

# Dry run
# Uncomment the following line to upload the lifecycle
$(aws s3api put-bucket-lifecycle-configuration --bucket $bucket --lifecycle-configuration file://policy.json)
echo "Updating lifecycle configuration for bucket $bucket"

done