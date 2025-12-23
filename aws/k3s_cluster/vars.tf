variable "region" {
  type = string
  default = "ap-south-1"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "master_vm_tag" {
  type = map(string)
  default = {
    Name="k3s-master-node"
  }
}
variable "worker_vm_tag" {
  type = map(string)
  default = {
    Name="k3s-worker-node"
  }
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

variable "private_key_path" {
  type = string
  description = "for ssh to created host"
}