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

  description = var.ec2amicreate_role_description
  name        = var.ec2amicreate_role_name
  policy      = data.aws_iam_policy_document.assume_ec2amicreate_role_doc.json
}
