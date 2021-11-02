module "provisionaccount" {
  source = "github.com/cisagov/provisionaccount-role-tf-module"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  users_account_id                  = local.users_account_id
}

# Attach a policy allowing this role to read organization information.
# This is necessary since we can't use the role created in this repo
# for this purpose since we need to do this to create that role.
resource "aws_iam_role_policy_attachment" "read_organization" {
  policy_arn = "arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess"
  role       = module.provisionaccount.provisionaccount_role.name
}

# Attach a policy allowing this role to administer the Service Catalog.
# This is needed to create the Service Catalog portfolio or import one
# created by Control Tower.
resource "aws_iam_role_policy_attachment" "admin_servicecatalog" {
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess"
  role       = module.provisionaccount.provisionaccount_role.name
}
