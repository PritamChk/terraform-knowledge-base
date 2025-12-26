output "vm_type_show" {
  value = "The selected VM type is : ${var.vm_type}"
}
output "fingerprint" {
  value = data.aws_key_pair.example.fingerprint
}

output "key_name" {
  value = data.aws_key_pair.example.key_name
}
output "key_id" {
  value = data.aws_key_pair.example.id
}

output "pmapp_vm_public_ip" {
  value = aws_instance.pmapp_vm.public_ip
}