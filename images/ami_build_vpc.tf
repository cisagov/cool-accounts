# The VPC where new AMIs will be built
resource "aws_vpc" "ami_build" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.provisionvpcs_policy_attachment
  ]

  cidr_block = var.ami_build_cidr

  tags = {
    Name = "AMI Build"
  }
}

# Public (only) subnet of the AMI build VPC
resource "aws_subnet" "ami_build_public" {
  depends_on = [
    aws_internet_gateway.ami_build
  ]

  cidr_block = var.ami_build_cidr
  tags = {
    Name = "AMI Build"
  }
  vpc_id = aws_vpc.ami_build.id
}

# The internet gateway for the AMI build VPC
resource "aws_internet_gateway" "ami_build" {
  tags = {
    Name = "AMI Build"
  }
  vpc_id = aws_vpc.ami_build.id
}

# Default route table for AMI build VPC, which routes all
# external traffic through the internet gateway
resource "aws_default_route_table" "ami_build" {
  default_route_table_id = aws_vpc.ami_build.default_route_table_id

  tags = {
    Name = "AMI Build"
  }
}

# Default route: Route all external traffic through the internet gateway
resource "aws_route" "external_traffic_through_internet_gateway" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ami_build.id
  route_table_id         = aws_default_route_table.ami_build.id
}

# ACL for the public subnet of the AMI build VPC
resource "aws_network_acl" "ami_build_public" {
  subnet_ids = [
    aws_subnet.ami_build_public.id,
  ]
  tags = {
    Name = "AMI Build"
  }
  vpc_id = aws_vpc.ami_build.id
}

# NOTE: No security group is needed for the AMI build instance, since
# packer creates a temporary security group that only allows inbound
# port 22 and anything outbound.
