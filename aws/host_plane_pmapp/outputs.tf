output "vm_type_show" {
  value = "The selected VM type is : ${var.vm_type}"
}

output "pmapp_vm_public_ip" {
  value = aws_instance.pmapp_vm.public_ip
}

output "vpc_id" {
  value = aws_vpc.pmapp_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.pmapp_vpc.cidr_block
}

output "sec_group_id" {
  value = aws_security_group.pm_app_sg.id
}

output "sec_group_id" {
  value = aws_security_group.pm_app_sg.id
}