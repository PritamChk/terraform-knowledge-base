output "master_node_public_ip" {
  value = module.master_node.vm_public_address
}
output "worker_node_public_ip" {
  value = module.worker_node.vm_public_address
}
