# Allow ingress from anywhere via ssh
resource "aws_network_acl_rule" "ami_build_public_ingress_from_anywhere_via_ssh" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 22
  network_acl_id = aws_network_acl.ami_build_public.id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = "100"
  to_port        = 22
}

# Allow ingress from anywhere via ephemeral ports
resource "aws_network_acl_rule" "ami_build_public_ingress_from_anywhere_via_ephemeral_ports" {
  count = length(local.tcp_and_udp)

  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 1024
  network_acl_id = aws_network_acl.ami_build_public.id
  protocol       = local.tcp_and_udp[count.index]
  rule_action    = "allow"
  rule_number    = 120 + count.index
  to_port        = 65535
}

# Allow egress to anywhere via any protocol and port
resource "aws_network_acl_rule" "ami_build_public_egress_to_anywhere_via_any_port" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 0
  network_acl_id = aws_network_acl.ami_build_public.id
  protocol       = "-1"
  rule_action    = "allow"
  rule_number    = 140
  to_port        = 0
}
