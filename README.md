# terraform-knowledge-base

## Repository Structure

```
terraform-knowledge-base/
└── aws/
    └── hello-world/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        ├── terraform.tfvars
        └── imgs/
```

## Getting Started

### Prerequisites
- Terraform >= 1.0

### Usage

1. Navigate to the desired example:
   ```bash
   cd aws/hello-world
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review planned changes:
   ```bash
   terraform plan
   ```

4. Apply configuration:
   ```bash
   terraform apply
   ```

5. Destroy resources when done:
   ```bash
   terraform destroy
   ```

## Examples

- **aws/hello-world**: Basic Terraform configuration demonstrating AWS resource provisioning


### Reference Git Repo for Learning :

> [Click Here: terraform-zero-to-hero](https://github.com/iam-veeramalla/terraform-zero-to-hero.git)

> [YouTube Series](https://youtube.com/playlist?list=PLdpzxOOAlwvI0O4PeKVV1-yJoX2AqIWuf&si=KpazBFGeN2XQsmGO)