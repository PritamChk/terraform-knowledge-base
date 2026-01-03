output "app_vpc_id" {
  value = module.app_vpc.default_vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}

# 1. Bastion Public IP (For your SSH Jump)
output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = module.bastion.public_ip
}

# 2. App Servers Private IPs (To know where to jump to)
output "app_private_ips" {
  description = "List of Private IPs for the App Servers"
  # Since we used 'for_each' on the module, we loop through the results to get a list
  value = [for instance in module.app_servers : instance.private_ip]
}

# 3. Load Balancer DNS (From previous step, good to keep)
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}
