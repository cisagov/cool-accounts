# Security group for manually finishing AMI setup for imported Windows AMIs
resource "aws_security_group" "windows_ami" {
  # We include a name for convenience because this security group will be
  # manually selected in the AWS console (for now).
  name = var.windows_ami_sg_name

  vpc_id = aws_vpc.ami_build.id

  tags = {
    Name = "AMI Build"
  }
}

# Allow ingress to instances via RDP
resource "aws_security_group_rule" "windows_ami_ingress_via_rdp" {
  for_each = toset(["tcp", "udp"])

  security_group_id = aws_security_group.windows_ami.id
  type              = "ingress"
  protocol          = each.value
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3389
  to_port           = 3389
}

# Allow unfettered egress from instances
resource "aws_security_group_rule" "windows_ami_egress_to_anywhere" {
  security_group_id = aws_security_group.windows_ami.id
  type              = "egress"
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 65535
}
