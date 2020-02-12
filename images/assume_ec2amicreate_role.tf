# IAM policy document that allows assumption of the EC2AMICreate role
# in the Images account
data "aws_iam_policy_document" "assume_ec2amicreate_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      aws_iam_role.ec2amicreate_role.arn
    ]
  }
}

# The IAM policy allowing assumption of the EC2AMICreate role in the
# Images account
resource "aws_iam_policy" "assume_ec2amicreate_role" {
  provider = aws.users

  description = var.assume_ec2amicreate_policy_description
  name        = var.assume_ec2amicreate_policy_name
  policy      = data.aws_iam_policy_document.assume_ec2amicreate_role_doc.json
}
