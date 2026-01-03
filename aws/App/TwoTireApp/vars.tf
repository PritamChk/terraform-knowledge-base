variable "access_key" {
  type        = string
  description = "read from Environment variable TF_VAR_access_key | later will integrate with Hashicorp Vault"
}

variable "secret_key" {
  type        = string
  description = "read from Environment variable TF_VAR_secret_key | later will integrate with Hashicorp Vault"
}

variable "region_az_list" {
  type        = list(string)
  description = "AZ-a and AZ-b only allowed for now | 03-01-2026"
}
