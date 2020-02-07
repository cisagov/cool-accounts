# The "default" provider that is used to create resources inside the
# new account
provider "aws" {
}

# The provider that is used to create resources inside the users
# account
provider "aws" {
  alias = "users"
}
