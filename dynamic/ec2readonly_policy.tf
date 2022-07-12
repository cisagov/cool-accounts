# ------------------------------------------------------------------------------
# Create the IAM policy that allows read access to some EC2 attributes
# in the dynamic account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "ec2readonly_doc" {
  statement {
    actions = [
      "ec2:DescribeAddresses",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "ec2:DescribeTags",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2readonly_policy" {
  description = var.ec2readonly_role_description
  name        = var.ec2readonly_role_name
  policy      = data.aws_iam_policy_document.ec2readonly_doc.json
}
