# ------------------------------------------------------------------------------
# Create the IAM role that allows all of the permissions necessary to
# provision all resources related to the publish-egress-ip Lambda in
# the DNS account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "provisionpublishegressip_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.provisionpublishegressip_role_description
  name               = var.provisionpublishegressip_role_name
}

resource "aws_iam_role_policy_attachment" "provisionpublishegressip_policy_attachment" {
  policy_arn = aws_iam_policy.provisionpublishegressip_policy.arn
  role       = aws_iam_role.provisionpublishegressip_role.name
}
