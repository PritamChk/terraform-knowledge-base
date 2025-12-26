# Learning of data source aws_ami --> fetch details of latest ami for aws 2023 linux
data "aws_ami" "ec2_ami" {
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["al2023-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## Key Pair Exists check
data "aws_key_pair" "pmapp_key" {
  key_name = var.vm_key_name
}

## Creating EC2 instance with variable vm_type
resource "aws_instance" "pmapp_vm" {
  ami                         = data.aws_ami.ec2_ami.id
  instance_type               = var.vm_type
  key_name                    = var.vm_key_name
  associate_public_ip_address = true
  tags = var.vm_tags
  lifecycle {
    prevent_destroy = true
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.vm_private_key_path)
    host        = self.public_ip
  }

  provisioner "file" {
    source = "scripts/install_plane.sh"
    destination = "/home/ec2-user/install_plane.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/install_plane.sh",
      "sudo /home/ec2-user/install_plane.sh"
    ]
  }

}
