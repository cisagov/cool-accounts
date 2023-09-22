# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the Users account and the
# Control Tower service to assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_users_control_tower_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      # Delegate access to this role to the Users account.
      identifiers = [local.users_account_id]
    }

    principals {
      type = "Service"
      # Delegate access to this role to the Control Tower service.
      identifiers = ["controltower.amazonaws.com"]
    }
  }
}
