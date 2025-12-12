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
  type = string
}
variable "worker_vm_tag" {
  type = string
}

variable "os" {
  type = string
}

variable "key_name" {
  type = string
}