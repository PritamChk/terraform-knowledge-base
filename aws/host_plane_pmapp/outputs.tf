output "vm_type_show" {
  value = "The selected VM type is : ${var.vm_type}"
}

output "pmapp_vm_public_ip" {
  value = aws_instance.pmapp_vm.public_ip
}