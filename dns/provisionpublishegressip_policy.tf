# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary to
# provision all resources related to the publish-egress-ip Lambda in
# the DNS account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionpublishegressip_doc" {

  statement {
    actions = [
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "acm:ListTagsForCertificate",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "cloudfront:CreateDistribution",
      "cloudfront:DeleteDistribution",
      "cloudfront:GetDistribution",
      "cloudfront:ListTagsForResource",
      "cloudfront:TagResource",
      "cloudfront:UpdateDistribution",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "events:DeleteRule",
      "events:DescribeRule",
      "events:ListTagsForResource",
      "events:ListTargetsByRule",
      "events:PutRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "events:TagResource",
    ]

    resources = [
      format("arn:aws:events:*:%s:rule/%s*",
      local.dns_account_id, var.publishegressip_lambda_name)
    ]
  }

  statement {
    actions = [
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
      "iam:TagPolicy",
      "iam:UntagPolicy",
    ]

    resources = [
      format("arn:aws:iam::%s:policy/%s",
      local.dns_account_id, var.publishegressip_role_name),
      format("arn:aws:iam::%s:policy/add_security_headers-role",
      local.dns_account_id),
    ]
  }

  statement {
    actions = [
      "iam:AttachRolePolicy",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "iam:PutRolePolicy",
      "iam:TagRole",
      "iam:UpdateRoleDescription",
    ]

    resources = [
      format("arn:aws:iam::%s:role/%s",
      local.dns_account_id, var.publishegressip_role_name),
      format("arn:aws:iam::%s:role/add_security_headers-role",
      local.dns_account_id),
    ]
  }

  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = [
      format("arn:aws:iam::%s:role/aws-service-role/replicator.lambda.amazonaws.com/AWSServiceRoleForLambdaReplicator", local.dns_account_id)
    ]
  }

  statement {
    actions = [
      "lambda:AddPermission",
      "lambda:CreateFunction",
      "lambda:DeleteFunction",
      "lambda:EnableReplication",
      "lambda:GetFunction",
      "lambda:GetFunctionCodeSigningConfig",
      "lambda:GetPolicy",
      "lambda:ListVersionsByFunction",
      "lambda:RemovePermission",
      "lambda:TagResource",
      "lambda:UntagResource",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
    ]

    resources = [
      format("arn:aws:lambda:*:%s:function:add_security_headers",
      local.dns_account_id),
      format("arn:aws:lambda:*:%s:function:add_security_headers:*",
      local.dns_account_id),
      format("arn:aws:lambda:*:%s:function:%s",
      local.dns_account_id, var.publishegressip_lambda_name),
      format("arn:aws:lambda:*:%s:function:%s:*",
      local.dns_account_id, var.publishegressip_lambda_name),
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:DescribeLogGroups",
      "logs:ListTagsLogGroup",
      "logs:PutRetentionPolicy",
    ]

    resources = [
      format("arn:aws:logs:*:%s:log-group::log-stream:*", local.dns_account_id),
      format("arn:aws:logs:*:%s:log-group:/aws/lambda/add_security_headers:log-stream:*",
      local.dns_account_id),
      format("arn:aws:logs:*:%s:log-group:/aws/lambda/%s:log-stream:*",
      local.dns_account_id, var.publishegressip_lambda_name)
    ]
  }

  statement {
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteBucketWebsite",
      "s3:DeleteObject",
      "s3:Get*",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:PutBucketAcl",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketTagging",
      "s3:PutBucketVersioning",
      "s3:PutBucketWebsite",
      "s3:PutEncryptionConfiguration",
      "s3:PutObject",
      "s3:PutObjectTagging",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisionpublishegressip_policy" {
  description = var.provisionpublishegressip_role_description
  name        = var.provisionpublishegressip_role_name
  policy      = data.aws_iam_policy_document.provisionpublishegressip_doc.json
}
