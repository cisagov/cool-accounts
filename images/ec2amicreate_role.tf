# ------------------------------------------------------------------------------
# Create the IAM role that allows all of the EC2 actions necessary to
# create an AMI in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "ec2amicreate_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.ec2amicreate_role_description
  name               = var.ec2amicreate_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "ec2amicreate_policy_attachment" {
  policy_arn = aws_iam_policy.ec2amicreate_policy.arn
  role       = aws_iam_role.ec2amicreate_role.name
}
