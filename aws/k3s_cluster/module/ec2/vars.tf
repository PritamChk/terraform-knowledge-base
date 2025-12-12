

variable "ami" {
  type        = string
  description = "AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the EC2 instance"
}
