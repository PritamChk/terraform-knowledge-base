# 1. Get the "ID Card" for AWS S3
data "aws_prefix_list" "s3" {
  name = "com.amazonaws.${var.region}.s3"
}

module "private_ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.quiz_vpc_name}-private-sg"
  description = "Security group for App VM to communicate with LB using HTTP port open within VPC"
  vpc_id      = module.app_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8000
      to_port     = 9000
      protocol    = "tcp"
      description = "quiz-app-service ports"
      cidr_blocks = join(",", module.app_vpc.public_subnets_cidr_blocks)
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "quiz-app-service ports"
      cidr_blocks = join(",", module.app_vpc.public_subnets_cidr_blocks)
    }
  ]
  ## For S3
  egress_with_prefix_list_ids = [
    {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      prefix_list_ids = data.aws_prefix_list.s3.id
      description     = "Allow secure access to S3 Gateway Endpoint"
    }
  ]
}

# =========================================================
# 1. PUBLIC SG (For the Jump Server / Public EC2)
# =========================================================
module "public_ec2_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.quiz_vpc_name}-public-sg"
  description = "Allow SSH from the Internet"
  vpc_id      = module.app_vpc.vpc_id

  # Allow SSH from the whole world
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Allow standard internet access (updates, etc.)
  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}

module "load_balancer" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "${var.quiz_vpc_name}-lb-sg"
  description         = "Security group for LB to communicate with HTTP port open within VPC"
  vpc_id              = module.app_vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
}
