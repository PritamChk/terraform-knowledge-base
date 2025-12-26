terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.27.0"
    }
  }
  backend "s3" {
    bucket = "tf-learning-s3b-pc"
    key    = "plane/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

