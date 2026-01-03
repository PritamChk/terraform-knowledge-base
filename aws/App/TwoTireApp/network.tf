locals {
  vpc_name               = var.quiz_vpc_name
  availability_zone_list = ["${var.region}a", "${var.region}b"]
  cidr                   = var.quiz_vpc_cidr
  public_subnets         = var.quiz_vpc_public_subnet_cidr_block_list
  private_subnets        = var.quiz_vpc_private_subnet_cidr_block_list
  vpc_tags               = var.vpc_tags
}

# Single NAT Gateway
# enable_nat_gateway = true
# single_nat_gateway = true
# one_nat_gateway_per_az = false

module "app_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = local.cidr

  azs             = local.availability_zone_list
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  # NAT GATEWAY CONFIG
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = local.vpc_tags
}

module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  
  # Link to your existing VPC
  vpc_id = module.app_vpc.vpc_id

  endpoints = {
    s3 = {
      # 1. Specify the Service
      service = "s3"
      
      # 2. CRITICAL: Force it to be a Gateway (Standard/Free type)
      service_type = "Gateway"

      route_table_ids = module.app_vpc.private_route_table_ids

      tags = {
        Name = "${var.quiz_vpc_name}-s3-endpoint"
      }
    }
  }
}