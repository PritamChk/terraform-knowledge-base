#### SECRETS MANAGED VIA TF VARS ####
variable "AWS_ACCESS_KEY" {
  type = string
}

variable "AWS_DEFAULT_REGION" {
  type = string
  default = "ap-south-1"
}

variable "AWS_SECRET_KEY" {
  type = string
  sensitive = true
}
#### VM AND IMG MANAGED VIA TF VARS ####
## Example of Single String Variable
variable "AmazonLinux2023AMI" {
  type = string
  default = "ami-00ca570c1b6d79f36"
  description = "Amazon Linux 2023 | Free tier  | kernel-6.1 AMI | LTS - 5 Years | HVM | SSD | 64-bit x86"
}
variable "RHELinux10" {
  type = string
  default = "ami-01ca13db604661046"
  description = "Red Hat Enterprise Linux 10 | Free tier | HVM | SSD | 64-bit x86"
}

## Example of Instance Type Variable
variable "InstanceType" {
  type = map(string)
  default = {
    freeVM = "t2.micro",
    smallVM = "t2.small",
    mediumVM = "t2.medium" ,
    largeVM = "t2.large"
  }
  description = "Instance type to be used for EC2 instances"
}
