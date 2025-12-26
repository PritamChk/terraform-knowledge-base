vm_key_name = "aws-k3s-key"

vm_tags = {
  "name"      = "app-plane-vm-1"
  environment = "dev"
  created_by  = "terraform"
  author      = "team-alpha"
}

vm_private_key_path = "/home/ec2-user/.ssh/aws-k3s-key.pem"

script_params = {
  server_name = "plane-app-vm-1"
  time_zone   = "Asia/Thimphu"
  http_port   = "9090"
  https_port  = "9443"
}