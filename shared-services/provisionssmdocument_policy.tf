# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision the SSM Document resource required in this account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionssmdocument_policy_doc" {
  statement {
    actions = [
      "ssm:CreateDocument",
      "ssm:DeleteDocument",
      "ssm:DescribeDocument*",
      "ssm:GetDocument",
      "ssm:UpdateDocument*",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.sharedservices.account_id}:document/SSM-SessionManagerRunShell",
    ]
  }
}

resource "aws_iam_policy" "provisionssmdocument_policy" {
  description = var.provisionssmdocument_policy_description
  name        = var.provisionssmdocument_policy_name
  policy      = data.aws_iam_policy_document.provisionssmdocument_policy_doc.json
}
