// syntax is compatible with specific versions of Terraform, starting at 0.13
terraform {
  required_version = ">= 0.13.0, < 1.0.0"
}

// instantiate AWS provider with a region
provider "aws" {
  region  = "eu-west-1"
}

// create 100 users
module "users" {
  source = "./modules/cloudesk-user/"
  for_each = toset([
    for i in range(100) : format("user-%02d", i)
  ])

  name = each.key

  providers = {
    aws = aws
  }
}
