locals {
  server_name = var.script_params["server_name"]
  time_zone   = var.script_params["time_zone"]
  http_port   = var.script_params["http_port"]
  https_port  = var.script_params["https_port"]
}

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
  subnet_id                   = aws_subnet.pmapp_public_subnet_1a.id
  vpc_security_group_ids      = [aws_security_group.pm_app_sg.id]
  tags                        = var.vm_tags
  lifecycle {
    prevent_destroy = false
  }
}

resource "null_resource" "install_pmapp" {
  depends_on = [aws_instance.pmapp_vm]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.vm_private_key_path)
    host        = aws_instance.pmapp_vm.public_ip
  }

  provisioner "file" {
    source      = "scripts/install_plane.sh"
    destination = "/home/ec2-user/install_plane.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/install_plane.sh",
      "sudo /home/ec2-user/install_plane.sh ${local.server_name} ${local.time_zone} ${aws_instance.pmapp_vm.public_ip} ${local.http_port} ${local.https_port}"
    ]
  }
}
