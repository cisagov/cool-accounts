# ------------------------------------------------------------------------------
# Create the IAM role that allows all necessary permissions to provision
# AWS accounts via Control Tower.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "describeavailabilityzones_policy" {
  statement {
    actions   = ["ec2:DescribeAvailabilityZones"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "controltoweradmin_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_users_only_doc.json
  description        = var.controltoweradmin_role_description
  # This role requires the EC2 permission below in addition to the standard
  # AWS policies (attached further below) to function as intended.
  inline_policy {
    name   = "DescribeAvailabilityZonesPolicy"
    policy = data.aws_iam_policy_document.describeavailabilityzones_policy.json
  }
  # We use the largest possible maximum session duration value of 12 hours
  # since this role can be used to provision many AWS accounts consecutively
  # and it may take up to 30 minutes for each account to be provisioned (it
  # is currently not possible to provision more than one account at a time
  # via Control Tower).
  max_session_duration = 43200 # 12 hours
  name                 = var.controltoweradmin_role_name
}

# Attach necessary IAM policies to the role
resource "aws_iam_role_policy_attachment" "awscontroltowerservicerole_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
  role       = aws_iam_role.controltoweradmin_role.name
}

resource "aws_iam_role_policy_attachment" "awsservicecatalogadmin_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess"
  role       = aws_iam_role.controltoweradmin_role.name
}

resource "aws_iam_role_policy_attachment" "organizationsfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSOrganizationsFullAccess"
  role       = aws_iam_role.controltoweradmin_role.name
}
