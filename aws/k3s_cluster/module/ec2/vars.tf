variable "region" {
  type = string
  default = "ap-south-1"
}

variable "os" {
  type = string
  description = "AWS Linux 2023"
}

variable "vm_type" {
  type = string
  default = "t3.medium"
}

variable "vm_tag" {
  type = string
}

variable "key_name" {
  type = string
}
