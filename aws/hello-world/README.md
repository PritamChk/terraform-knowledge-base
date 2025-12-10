
# Terraform Hello World Example

## Overview
This is a basic Terraform example that creates an AWS S3 bucket.

## Prerequisites
- Terraform installed 
- AWS account configured with credentials
- AWS CLI configured

## Configuration

Create a `main.tf` file:

```hcl
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "hello_world" {
    bucket = "my-hello-world-bucket-${data.aws_caller_identity.current.account_id}"
}

data "aws_caller_identity" "current" {}

output "bucket_name" {
    value       = aws_s3_bucket.hello_world.id
    description = "The name of the S3 bucket"
}
```

## Usage

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply configuration
terraform apply

# Destroy resources
terraform destroy
```

## Output
After applying, you'll see the created S3 bucket name in the output.
## Cleanup