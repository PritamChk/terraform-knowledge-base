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

variable "key_name" {
  type = string
  default = null
}

variable "tags" {
  type = map(string)
  description = "Tags to apply to the VM"
  default = {}
}
