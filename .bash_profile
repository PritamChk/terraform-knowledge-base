export AWS_ACCESS_KEY=$(cat .aws_secrets/access_key | base64 -d)
export AWS_SECRET_KEY=$(cat .aws_secrets/secret_key | base64 -d)
export AWS_DEFAULT_REGION=$(cat .aws_secrets/default_region | base64 -d)