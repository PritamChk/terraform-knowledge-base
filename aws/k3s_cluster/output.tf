output "master_node_public_ip" {
  value = module.master_node.public_ip
}
output "worker_node_public_ip" {
  value = module.worker_node.public_ip
}
