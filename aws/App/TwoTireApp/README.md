## Planning & Execution

1. Creating base file structure for provider aws
1. Setting Variables
1. Decided to use terraform available modules from Terraform registry
   1. [IAM Module Link 404](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest)
1. Designed architecture diagram in `erase.io`
   1. ![arch-diag-1-404-](./imgs/arch-diag-1.png)
1. List the terraform modules I'm going to use:
   1. `iam`
   1. `vpc`
   1. `ec2`
   1. `security-group`
   1. `alb`
   1. `s3`
1. Terraform `init` o/p:
   1. ![init-404](imgs/tf_init.png)
1. create a terraform workspace for stg environment
   1. `terraform workspace new`
   1. ![ws-create-404](imgs/ws_create.png)
   1. Switch workspace
   1. `terraform workspace select <ws-name>`
   1. ![ws-select-404](imgs/ws_select.png)
1. Start Writing code in below sequence
   1. code for VPC, While creating vpc points observed or decision taken :
   1. As I'm currently set region to `ap-south-1` - I've decided to go ahead with 2 **`availability zones`** - here Idea is
      1. either use dynamic variables (in `list`) for az names like **`${region}a`** and **`${region}b`**
      1. Or else go for extract that az details dynamically using `data` `block` in `terraform`
      1. for time being chosen to move forward with `variable: list(string)` with string interpolation strategy.
   1. While writing VPC - got error on CIDR block related :
      1. ![cidr-math-issue-404](imgs/cidr_math_issue.png)
      1. understood the CIDR range and cidr math properly and changed the code accordingly.
      1. Created `terraform plan` for VPC and that time while analyzing I've understood again I did a mistake of CIDR block overlapping for `private` and `public` subnet

      1.  > ⚠️ Critical Warning: CIDR Overlap Detected Before you run terraform apply, you must fix a conflict in your IP ranges. Private Subnet 0 tries to take: 10.0.0.0/18 (IPs 10.0.0.0 to 10.0.63.255). Public Subnet 0 tries to take: 10.0.0.0/24 (IPs 10.0.0.0 to 10.0.0.255). The Problem: The Public Subnet is inside the Private Subnet. AWS will reject this because two subnets cannot share the same IP addresses. The Fix: Change the Private Subnet CIDRs to start after the public ones, or use non-overlapping ranges (e.g., Private starts at 10.0.128.0/18).
