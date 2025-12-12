resource "aws_instance" "vm_name" {
  ami = "${var.os}"
  instance_type = "${var.vm_type}"
  key_name = var.key_name
  tags = {
    Name = "${var.vm_tag}"
  }
}