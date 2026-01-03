module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.4.0"

  name   = "${var.quiz_vpc_name}-alb"
  vpc_id = module.app_vpc.vpc_id

  # 1. PLACEMENT
  subnets = module.app_vpc.public_subnets

  # 2. SECURITY
  # v9 automatically creates a security group if you don't pass one, 
  # but since you created one externally, we attach it here:
  create_security_group = false # Disable module's auto-SG
  security_groups       = [module.load_balancer.security_group_id]

  # 3. ACCESS LOGS (Optional, good practice to disable if not needed to save $)
  enable_deletion_protection = false

  # 4. LISTENERS
  listeners = {
    http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "app_targets"
      }
    }
  }

  # 5. TARGET GROUPS
  target_groups = {
    app_targets = {
      name_prefix = "app-"
      protocol    = "HTTP"
      port        = 8000
      target_type = "instance"

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
      }

      # v9 allows attaching targets directly here if you have a static list.
      # However, since you are using a dynamic loop of instances, 
      # keeping the external attachment resource (Step 6) is cleaner.
      create_attachment = false
    }
  }

  tags = {
    Environment = "dev"
  }
}

# -------------------------------------------------------------------
# 6. ATTACHMENT (The "Glue")
# -------------------------------------------------------------------
resource "aws_lb_target_group_attachment" "app_server_attachment" {
  # Loop through every App Server created in ec2.tf
  for_each = module.app_servers

  # v9 output change: target_groups is now a map
  target_group_arn = module.alb.target_groups["app_targets"].arn

  # The Instance ID
  target_id = each.value.id
  port      = 8000
}
