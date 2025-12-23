terraform {
  backend "s3" {
    bucket = "tf-learning-s3b-23dec25"
    key    = "dev_tfstates/terraform.tfstate"
    region = "${var.region}"
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