module "master_node" {
  source        = "../module/ec2"
  ami           = var.os               # your AMI ID
  instance_type = var.vm_type          # e.g., t3.medium
  key_name      = var.key_name         # existing key pair
  tags          = var.master_vm_tag    # map of tags
}

module "worker_node" {
  source        = "../module/ec2"
  ami           = var.os
  instance_type = var.vm_type
  key_name      = var.key_name
  tags          = var.worker_vm_tag
}
