# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision the SSM Document resource and set up SSM session
# logging in this account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionssmsessionmanager_policy_doc" {
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

resource "aws_iam_policy" "provisionssmsessionmanager_policy" {
  description = var.provisionssmsessionmanager_policy_description
  name        = var.provisionssmsessionmanager_policy_name
  policy      = data.aws_iam_policy_document.provisionssmsessionmanager_policy_doc.json
}
