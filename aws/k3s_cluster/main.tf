module "master_node" {
  source        = "./module/ec2"
  ami           = var.os               # your AMI ID
  instance_type = var.vm_type          # e.g., t3.medium
  key_name      = var.key_name         # existing key pair
  tags          = var.master_vm_tag    # map of tags
}

resource "null_resource" "master_setup" {
  depends_on = [ module.master_node ]
  connection {
    type = "ssh"
    user = "ec2-user"
    host = module.master_node.public_ip
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "scripts/master.sh"
    destination = "/home/ec2-user/master.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod +x /home/ec2-user/master.sh '' '' '${module.master_node.public_ip}'",
      "sudo /home/ec2-user/master.sh"
     ]
  }
  provisioner "local-exec" {
    # Command to retrieve the token and save it locally
    command = "ssh -i ${var.private_key_path} ec2-user@${module.master_node.public_ip} 'cat /tmp/token.txt' > token.txt"
  }
}

# Output the token for use in the worker setup (use the file content for simplicity)
data "local_file" "k3s_token" {
  # This ensures the data block runs after the master setup is complete and the token file exists
  depends_on = [null_resource.master_setup]
  filename   = "token.txt"
}

module "worker_node" {
  source        = "./module/ec2"
  ami           = var.os
  instance_type = var.vm_type
  key_name      = var.key_name
  tags          = var.worker_vm_tag
}

resource "null_resource" "worker_setup" {
  depends_on = [ null_resource.master_setup ]
  connection {
    type = "ssh"
    user = "ec2-user"
    host = module.worker_node.public_ip
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "scripts/worker.sh"
    destination = "/home/ec2-user/worker.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /home/ec2-user/worker.sh",
      "sudo /home/ec2-user/worker.sh '' '' '${module.master_node.public_ip}' '${trimspace(data.local_file.k3s_token.content)}'"
     ]
  }

}
