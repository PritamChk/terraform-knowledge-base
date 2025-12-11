output "app_vm_public_ip" {
  value = module.appVm-1.vm-public-address
}

output "db_vm_public_ip" {
  value = module.dbVm-1.vm-public-address
}
