# Put our god-like IAM users in the gods group.
resource "aws_iam_user_group_membership" "gods" {
  for_each = toset(var.godlike_usernames)

  user = aws_iam_user.gods[each.key].name

  groups = [
    aws_iam_group.gods.name
  ]
}
