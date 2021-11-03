# ------------------------------------------------------------------------------
# Create the IAM role that allows all necessary permissions to provision
# AWS accounts via Control Tower.
# ------------------------------------------------------------------------------

# These are additional permissions needed besides those found in the managed
# AWS policies attached below.  These permissions are documented in the
# Control Tower User Guide in the "Automated Account Provisioning With
# IAM Roles" section:
# https://docs.aws.amazon.com/controltower/latest/userguide/controltower-ug.pdf
data "aws_iam_policy_document" "additionalpermissions_policy" {
  statement {
    actions = [
      "controltower:CreateManagedAccount",
      "controltower:DeregisterManagedAccount",
      "controltower:DescribeManagedAccount",
      "ec2:DescribeAvailabilityZones",
      "sso:AssociateProfile",
      "sso:CreateApplicationInstance",
      "sso:CreateProfile",
      "sso:CreateTrust",
      "sso:DescribeRegisteredRegions",
      "sso:GetApplicationInstance",
      "sso:GetPeregrineStatus",
      "sso:GetPermissionSet",
      "sso:GetProfile",
      "sso:GetSSOStatus",
      "sso:GetTrust",
      "sso:ListDirectoryAssociations",
      "sso:ListPermissionSets",
      "sso:ListProfileAssociations",
      "sso:ProvisionApplicationInstanceForAWSAccount",
      "sso:ProvisionApplicationProfileForAWSAccountInstance",
      "sso:ProvisionSAMLProvider",
      "sso:UpdateProfile",
      "sso:UpdateTrust",
      "sso-directory:AddMemberToGroup",
      "sso-directory:CreateUser",
      "sso-directory:DescribeDirectory",
      "sso-directory:DescribeGroups",
      "sso-directory:GetUserPoolInfo",
      "sso-directory:ListMembersInGroup",
      "sso-directory:SearchGroups",
      "sso-directory:SearchGroupsWithGroupName",
      "sso-directory:SearchUsers",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "controltoweradmin_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_users_control_tower_doc.json
  description        = var.controltoweradmin_role_description
  # This role requires the permissions below in addition to the standard
  # AWS policies (attached further below) to function as intended.
  inline_policy {
    name   = "AdditionalControlTowerPermissionsPolicy"
    policy = data.aws_iam_policy_document.additionalpermissions_policy.json
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
resource "aws_iam_role_policy_attachment" "organizationsfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSOrganizationsFullAccess"
  role       = aws_iam_role.controltoweradmin_role.name
}

resource "aws_iam_role_policy_attachment" "servicecatalogadminfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess"
  role       = aws_iam_role.controltoweradmin_role.name
}
