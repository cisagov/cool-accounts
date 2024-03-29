# ------------------------------------------------------------------------------
# Provision SSM Session Manager and configure it for session logging.
# ------------------------------------------------------------------------------

module "session_manager" {
  providers = {
    aws = aws
  }
  source = "github.com/cisagov/session-manager-tf-module"

  other_accounts = [
    local.users_account_id,
  ]
}
