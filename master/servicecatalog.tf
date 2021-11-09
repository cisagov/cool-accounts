# The Service Catalog portfolio below is created by Control Tower, but we
# define it here so that it can be imported into our Terraform state.
#
# NOTE: These resources should be commented out until Control Tower has been
# enabled in your account.  Once you have set up Control Tower, uncomment
# them and import your Control Tower Account Factory portfolio into your
# Terraform state via:
#
# terraform import aws_servicecatalog_portfolio.control_tower port-abcdefg012345
#
# After that is done, apply the Terraform in this directory to associate
# the Control Tower Admin role with your Control Tower portfolio so that the
# role has permission to use your portfolio.
resource "aws_servicecatalog_portfolio" "control_tower" {
  description   = "AWS Control Tower Account Factory Portfolio"
  name          = "AWS Control Tower Account Factory Portfolio"
  provider_name = "AWS Control Tower"
}

# Associate our Control Tower Account Factory portfolio with our
# Control Tower Admin role.
resource "aws_servicecatalog_principal_portfolio_association" "control_tower_admin" {
  portfolio_id  = aws_servicecatalog_portfolio.control_tower.id
  principal_arn = aws_iam_role.controltoweradmin_role.arn
}
