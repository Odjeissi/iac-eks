
# AWS DB Traffic SG

resource "aws_security_group" "allow_db_traffic" {
  name        = var.db_sg_name
  description = "Allow db inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.env}-${var.db_sg_name}"
    Environment = var.env
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_inbound_traffic" {
  for_each          = toset(var.allow_db_traffic.ports)
  security_group_id = aws_security_group.allow_db_traffic.id
  cidr_ipv4         = var.allowed_db_cidr
  from_port         = each.value
  ip_protocol       = var.allow_db_traffic.ip_protocol
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_db_outbound_traffic" {
  security_group_id = aws_security_group.allow_db_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
