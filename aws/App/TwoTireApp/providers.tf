terraform {
  backend "s3" {
    bucket = "tf-learning-s3b-pc"
    key    = "quizapptf/stg/terraform.tfstate"
    region = "ap-south-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  
}
