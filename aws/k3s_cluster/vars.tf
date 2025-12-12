variable "region" {
  type = string
  default = "ap-south-1"
}
variable "access_key" {
  type = string
}
variable "secret" {
  type = string
}

variable "master_vm_tag" {
  type = map(string)
  default = {}
}
variable "worker_vm_tag" {
  type = map(string)
  default = {}
}

variable "os" {
  type = string
}

variable "vm_type" {
  type = string
}

variable "key_name" {
  type = string
}
