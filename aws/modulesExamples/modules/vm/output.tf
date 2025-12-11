output "vm-public-address" {
  value  = aws_instance.project-vm.public_ip
  description = "Public IP address of the VM"
}