# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient permissions to create all
# AWS resources in the terraform account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "create_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.create_role_description
  name               = var.create_role_name
  tags               = var.tags
}

# Attach the desired IAM policies to the role
resource "aws_iam_role_policy_attachment" "create_policy_attachment" {
  policy_arn = aws_iam_policy.create_policy.arn
  role       = aws_iam_role.create_role.name
}

resource "aws_iam_role_policy_attachment" "iamfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  role       = aws_iam_role.create_role.name
}
