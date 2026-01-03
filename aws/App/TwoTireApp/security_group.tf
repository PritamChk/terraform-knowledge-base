
module "ec2_sg_quiz_vpc" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.quiz_vpc_name}-ec2-sg"
  description = "Security group for App VM to communicate with LB using HTTP port open within VPC"
  vpc_id      = module.app_vpc.vpc_id


  ingress_rules = ["ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8000
      to_port     = 9000
      protocol    = "tcp"
      description = "quiz-app-service ports"
      cidr_blocks = join(",", module.app_vpc.public_subnets_cidr_blocks)
    }
  ]
}

module "load_balancer" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "${var.quiz_vpc_name}-lb-sg"
  description         = "Security group for LB to communicate with HTTP port open within VPC"
  vpc_id              = module.app_vpc.vpc_id
  ingress_cidr_blocks = "0.0.0.0/0"
  ingress_rules       = ["http-80-tcp"]
}
