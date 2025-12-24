terraform {
  backend "s3" {
    bucket = "tf-learning-s3b-pc"
    key    = "dev_tfstates/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>6.27"
    }
  }
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region    = "${var.region}"  
}