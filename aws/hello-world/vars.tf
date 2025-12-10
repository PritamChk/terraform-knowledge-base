variable "AWS_ACCESS_KEY" {
  type = string
}

variable "AWS_DEFAULT_REGION" {
  type = string
  default = "ap-south-1"
}

variable "AWS_SECRET_KEY" {
  type = string
  sensitive = true
}