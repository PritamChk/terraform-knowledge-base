locals {
  vpc_name               = var.quiz_vpc_name
  availability_zone_list = var.region_az_list
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
