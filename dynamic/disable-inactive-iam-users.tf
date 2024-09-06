# ------------------------------------------------------------------------------
# Create the EventBridge event rule that triggers at a fixed cadence,
# kicking off a Lambda function that disables inactive IAM users.
# ------------------------------------------------------------------------------
module "disable-inactive-iam-users" {
  depends_on = [
    aws_iam_role_policy_attachment.read_lambda_bucket,
  ]
  providers = {
    aws = aws
  }

  source = "github.com/cisagov/disable-inactive-iam-users-tf-module"

  lambda_bucket_name = var.lambda_bucket_name
  lambda_key         = var.lambda_key
}
