module "master_node" {
  source = "../modulesExamples/modules/vm"
  ami_id = var.os
  instance_type = var.vm_type
  tags= var.master_vm_tag
}

module "worker_node" {
  source = "../modulesExamples/modules/vm"
  ami_id = var.os
  instance_type = var.vm_type
  tags = var.worker_vm_tag
  key_name = var.key_name
}
