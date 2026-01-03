###### BEFORE INIT MODULE ENLIST TO DOWNLOAD #######
# module "ec2-instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "6.1.5"
# }

# module "security-group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "5.3.1"
# }

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "6.5.1"
# }

# module "s3-bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "5.9.1"
# }

# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "10.4.0"
# }
###### END : BEFORE INIT MODULE ENLIST TO DOWNLOAD #######

# EC2 -> needed for 2 private and 1 jump-server for ssh with public ip
# Learning of data source aws_ami --> fetch details of latest ami for aws 2023 linux

locals {
  key_name = "aws-k3s-key"
  app_vm   = "private-quiz-app-vm"
}

data "aws_ami" "ec2_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
} # =========================================================
# 1. PUBLIC BASTION (Single Instance)
# =========================================================
resource "aws_instance" "bastion" {
  # 1. Use the AMI we fetched above
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # 2. Networking (Public)
  # Place in the first Public Subnet
  subnet_id = module.app_vpc.public_subnets[0]
  # IMPORTANT: We need this to be true for the Jumpbox
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.public_ec2_sg.security_group_id]

  # 3. Key (Update this!)
  key_name = local.key_name

  tags = {
    Name = "${var.quiz_vpc_name}-bastion"
    Role = "Bastion"
  }

}


# =========================================================
# 2. PRIVATE APP SERVERS (One per Private Subnet)
# =========================================================
resource "aws_instance" "app_servers" {
  # Create one instance for every Private Subnet found
  for_each = toset(module.app_vpc.private_subnets)

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # 1. Networking (Private)
  subnet_id                   = each.value # The subnet ID from the loop
  associate_public_ip_address = false      # No public IP for private apps
  vpc_security_group_ids      = [module.private_ec2_sg.security_group_id]

  # 2. Key
  key_name = local.key_name

  tags = {
    Name = "${var.quiz_vpc_name}-app-${each.key}"
    Role = "App-Server"
  }
}

