# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient access to Domain Manager-related
# S3 and DynamoDB resources to use them for a Terraform backend.  Note that
# this role does NOT allow access to non-Domain Manager S3 and DynamoDB
# resources.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "access_domainmanager_terraform_backend_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.access_domainmanager_terraform_backend_role_description
  name               = var.access_domainmanager_terraform_backend_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "access_domainmanager_terraform_backend_policy_attachment" {
  policy_arn = aws_iam_policy.access_domainmanager_terraform_backend_access_policy.arn
  role       = aws_iam_role.access_domainmanager_terraform_backend_role.name
}
