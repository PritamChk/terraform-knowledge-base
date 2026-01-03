module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.5"
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.9.1"
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.4.0"
}