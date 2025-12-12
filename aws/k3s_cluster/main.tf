module "master_node" {
  source        = "../modulesExamples/modules/vm"
  ami_id            = var.os
  instance_type = var.vm_type
  key_name      = var.key_name
  tags          = var.master_vm_tag
}
module "worker_node" {
  source        = "../modulesExamples/modules/vm"
  ami_id            = var.os
  instance_type = var.vm_type
  key_name      = var.key_name
  tags          = var.worker_vm_tag
}

