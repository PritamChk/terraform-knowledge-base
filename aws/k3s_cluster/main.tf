module "master_node" {
  source        = "../modulesExamples/modules/vm"
  os            = var.os
  vm_type       = var.vm_type
  key_name      = var.key_name   # if you want to pass it
  tag           = var.master_vm_tag
}

module "worker_node" {
  source        = "../modulesExamples/modules/vm"
  os            = var.os
  vm_type       = var.vm_type
  key_name      = var.key_name
  tag           = var.worker_vm_tag
}
