output "administerkmskeys_role" {
  value       = aws_iam_role.administerkmskeys_role
  description = "The IAM role that allows sufficient permissions to administer KMS keys in the Images account."
}

output "ami_kms_key" {
  value       = aws_kms_key.amis
  description = "The KMS key for encrypting AMIs in the Images account."
}

output "ec2amicreate_role" {
  value       = aws_iam_role.ec2amicreate_role
  description = "The IAM role that allows sufficient permissions to create AMIs in the Images account."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Images account."
}

output "provisionec2amicreateroles_role" {
  value       = aws_iam_role.provisionec2amicreateroles_role
  description = "The IAM role that allows sufficient permissions to provision IAM roles that can create AMIs in the Images account."
}

output "third_party_bucket" {
  value       = aws_s3_bucket.third_party
  description = "The S3 bucket for storing third-party files."
}
