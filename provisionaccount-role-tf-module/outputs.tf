output "provisionaccount_role_arn" {
  value       = aws_iam_role.provisionaccount_role.arn
  description = "The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in the new account."
}

# This value is actually an input variable, but we want to specify it
# again here.  The reason is simple, if lengthy to explain.
#
# Suppose we want to attach another policy to this role, and we have
# the ARN of this new policy.  The aws_iam_role_policy_attachment
# Terraform resource requires a policy ARN and a role name.  If we
# simply use the input variable when defining the
# aws_iam_role_policy_attachment resource, then the role may not
# actually exist when Terraform attempts to create the
# aws_iam_role_policy_attachment resource.  If we use this output
# instead then the role is guaranteed to exist when Terraform attempts
# to create the aws_iam_role_policy_attachment resource.
output "provisionaccount_role_name" {
  value       = aws_iam_role.provisionaccount_role.name
  description = "The name of the IAM role that allows sufficient permissions to provision all AWS resources in the new account."
}
