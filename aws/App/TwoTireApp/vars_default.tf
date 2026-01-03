variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "This is to ensure the created objects goes to Mumbai as it is near to Bhutan"
}

variable "quiz_vpc_name" {
  type        = string
  default     = "quiz_vpc"
  description = "user can set custom value for this "
}

variable "quiz_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/(1[6-9]|2[0-6])$", var.quiz_vpc_cidr))
    error_message = "For VPC CIDR Range | ip range pattern incorrect | also check for allowed /[value] : 16-26 allowed "
  }
}

variable "quiz_vpc_private_subnet_cidr_block_list" {
  type    = list(string)
  default = ["10.0.0.0/18", "10.0.64.0/18"]
  validation {
    # condition = can(regex("^([0-9]{1,3}\.){3}[0-9]{1,3}\/(1[7-9]|2[0-8])$",var.quiz_vpc_cidr))

    condition = alltrue([
      for cidr in var.quiz_vpc_private_subnet_cidr_block_list :
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/(1[7-9]|2[0-8])$", cidr))
    ])
    error_message = "For Subnet | ip range pattern incorrect for cidr block| also check for allowed /[value] : 17-28 allowed "
  }
}

variable "quiz_vpc_public_subnet_cidr_block_list" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
  validation {
    # condition = can(regex("^([0-9]{1,3}\.){3}[0-9]{1,3}\/(1[7-9]|2[0-8])$",var.quiz_vpc_cidr))

    condition = alltrue([
      for cidr in var.quiz_vpc_public_subnet_cidr_block_list :
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/(1[7-9]|2[0-8])$", cidr))
    ])
    error_message = "For Subnet | ip range pattern incorrect for cidr block| also check for allowed /[value] : 17-28 allowed "
  }
}


variable "vpc_tags" {
  type = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
    App         = "Quiz"
  }

}
