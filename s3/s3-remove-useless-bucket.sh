#!/bin/bash

buckets=("my-terraform-state-6661234")

for bucket in ${buckets[@]}; do
:
# exclude opening and closing brackets
if [ $bucket = "[" ] || [ $bucket = "]" ]; then
  continue
fi
bucket=$(echo "$bucket" | sed 's/"//g' | sed 's/,//g')

# Dry run
# Empty an S3 bucket
$(aws s3 rm s3://$bucket --recursive)

# Empty a versioned S3 bucket
# version=$(aws s3api list-object-versions \
#   --bucket "$bucket" \
#   --output=json \
#   --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')
# if [ $version != "" ]; then
#   $(aws s3api delete-objects --bucket $bucket \
#   --delete $version )
# fi

# Delete an S3 bucket
$(aws s3 rb s3://$bucket --force)
# Delete an S3 bucket
echo "Remove bucket - $bucket"

done

# list all bucket
aws s3 ls
