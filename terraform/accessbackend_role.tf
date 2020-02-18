# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient access to the S3 bucket
# and DynamoDB table to use them for a Terraform backend.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "access_terraform_backend_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.access_terraform_backend_role_description
  name               = var.access_terraform_backend_role_name
  tags               = var.tags
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "access_terraform_backend_policy_attachment" {
  policy_arn = aws_iam_policy.access_terraform_backend_access_policy.arn
  role       = aws_iam_role.access_terraform_backend_role.name
}
