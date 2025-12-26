variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "vm_type" {
  type        = string
  description = "It must of minimum t3.medium/t3a.medium to install docker engine"
  validation {
    condition     = can(regex("^t3\\.(medium|large|xlarge|2xlarge)$", var.vm_type))
    error_message = "Please choose among : t3.[medium|large|xlarge|2xlarge] vm types"
  }
}

variable "vm_key_name" {
  type        = string
  description = "pem key to ssh to server"
}

