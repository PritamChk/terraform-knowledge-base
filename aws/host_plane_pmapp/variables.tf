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
  default = "t3.medium"
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


variable "vm_tags" {
  type = map(string)
  description = "Tags can have instance name , env details, created_by:"
  default = {
    Name          = "pmapp-vm"
    environment   = "dev"
    created_by = "terraform"
  }
}


variable "vm_private_key_path" {
  type = string
  default = "/home/ec2-user/.ssh/my-key.ppy"
  description = "Path to the private key file to ssh to the instance"
}

variable "script_params" {
  type        = map(string)
  default     = {
    server_name="pmapp-server"
    time_zone="Asia/Kolkata" 
    http_port="9000"
    https_port="9443"
  }
  description = "Parameters to be passed to the install script"
}