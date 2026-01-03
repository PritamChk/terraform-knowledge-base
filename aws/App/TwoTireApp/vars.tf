variable "access_key" {
  type        = string
  description = "read from Environment variable TF_VAR_access_key | later will integrate with Hashicorp Vault"
}

variable "secret_key" {
  type        = string
  description = "read from Environment variable TF_VAR_secret_key | later will integrate with Hashicorp Vault"
}
