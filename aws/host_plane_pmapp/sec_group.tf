resource "aws_security_group" "pm_app_sg" {
  name        = "pm_app_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.pmapp_vpc.id

  tags = {
    Name = "pm_app_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "pm_app_sg_ipv4" {
  security_group_id = aws_security_group.pm_app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "pm_app_sg_ssh" {
  security_group_id = aws_security_group.pm_app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "ssh"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.pm_app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
