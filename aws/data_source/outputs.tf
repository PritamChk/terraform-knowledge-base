output "ami_id" {
  value = data.aws_ami.aws_linux.id
}
output "vm_pub_ip" {
  value = aws_instance.vm2.public_ip
}