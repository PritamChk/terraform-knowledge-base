vm_key_name = "aws-k3s-key"

vm_tags = {
  "name" = "app-plane-vm-1"
  environment = "dev"
  created_by = "terraform"
  author = "team-alpha"
}

private_key_path = "/home/ec2-user/.ssh/aws-k3s-key.pem"