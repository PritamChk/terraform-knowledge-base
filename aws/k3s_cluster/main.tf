module "master_node" {
  source = "../modulesExamples/modules/vm"
  ami_id = var.os
  vm_tag = var.master_vm_tag
  instance_type = var.vm_type
}

module "worker_node" {
  source = "../modulesExamples/modules/vm"
  ami_id = var.os
  vm_tag = var.worker_vm_tag
  instance_type = var.vm_type
}
