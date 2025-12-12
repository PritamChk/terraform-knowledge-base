provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret}"
  region    = "${var.region}"  
}