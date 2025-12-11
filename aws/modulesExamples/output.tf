output "app_vm_public_ip" {
  value = module.appVm-1.public_ip
}

output "db_vm_public_ip" {
  value = module.dbVm-1.public_ip
}
