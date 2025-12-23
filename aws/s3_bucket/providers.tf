terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>6.27"
    }
  }
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret}"
  region    = "${var.region}"  
}