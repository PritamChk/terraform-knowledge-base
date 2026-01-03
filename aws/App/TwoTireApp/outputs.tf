output "app_vpc_id" {
  value = module.app_vpc.default_vpc_id
}

# 1. Bastion Public IP
output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = aws_instance.bastion.public_ip
}

# 2. App Servers Private IPs
output "app_private_ips" {
  description = "List of Private IPs for the App Servers"
  # Loop through the resource map to get IPs
  value = [for instance in aws_instance.app_servers : instance.private_ip]
}

# 3. Load Balancer DNS (This stays the same if ALB is still a module)
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}
