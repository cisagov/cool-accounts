# Put our admin IAM users in the Terraform backend access and user
# account provisioners groups.
resource "aws_iam_user_group_membership" "gods" {
  for_each = var.godlike_usernames

  user = aws_iam_user.gods[each.key].name

  groups = [
    aws_iam_group.gods.name
  ]
}
