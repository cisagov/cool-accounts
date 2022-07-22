# ------------------------------------------------------------------------------
# Create the IAM role that allows read access to some EC2 attributes
# in the dynamic account.
# *** Note that this role is only assumable from the DNS account. ***
# ------------------------------------------------------------------------------

resource "aws_iam_role" "ec2readonly_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_dns_doc.json
  description        = var.ec2readonly_role_description
  name               = var.ec2readonly_role_name
}

resource "aws_iam_role_policy_attachment" "ec2readonly_policy_attachment" {
  policy_arn = aws_iam_policy.ec2readonly_policy.arn
  role       = aws_iam_role.ec2readonly_role.name
}
