module "master_node" {
  source        = "../modulesExamples/modules/vm"
  ami_id            = var.os
  instance_type = var.vm_type

}
module "worker_node" {
  source        = "../modulesExamples/modules/vm"
  ami_id            = var.os
  instance_type = var.vm_type

}

