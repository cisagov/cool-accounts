# ------------------------------------------------------------------------------
# Create the IAM role that allows read-only access to the S3 bucket
# where Terraform remote state is stored.  This is useful for cases when
# the remote state data is needed, but full access to the backend is not.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "read_terraform_state_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.read_terraform_state_role_description
  name               = var.read_terraform_state_role_name
  tags               = var.tags
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "read_terraform_state_policy_attachment" {
  policy_arn = aws_iam_policy.read_terraform_state_policy.arn
  role       = aws_iam_role.read_terraform_state_role.name
}
