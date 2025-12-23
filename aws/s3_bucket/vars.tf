variable "secret_key" {
  type = string
  description = "It stores the secret key to access AWS account to do admin tasks"
}
variable "access_key" {
  type = string
  description = "It stores the access key to access AWS account to do admin tasks"
}
variable "region" {
  type = string
  description = "It stores the region to create AWS resources"
  default = "ap-south-1"
}