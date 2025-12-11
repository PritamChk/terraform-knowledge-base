variable "ami_id" {
  type = string
  description = "OS | this is used to pass aws/rhl/other os ami id"
}

variable "instance_type" {
  type = string
  description = "this is used assign instance type | small , medium , large"
}

variable "project_name" {
  type = string
  default = "myTfProject"
  description = "just for testing purpose"
}