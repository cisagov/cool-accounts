resource "aws_dlm_lifecycle_policy" "default_ebs" {
  default_policy     = "VOLUME"
  description        = "Default policy to generate daily EBS snapshots"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  tags = {
    Name = "Default policy for EBS snapshots"
  }

  policy_details {
    copy_tags = true
    # Intervals below are in days
    create_interval = var.ebs_volume_snapshot_create_interval
    policy_language = "SIMPLIFIED"
    resource_type   = "VOLUME"
    retain_interval = var.ebs_volume_snapshot_retain_interval
  }
}
