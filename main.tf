// syntax is compatible with specific versions of Terraform, starting at 0.13
terraform {
  required_version = ">= 0.13.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "1.0.0"
    }
  }
}

// instantiate AWS provider with a region
provider "aws" {
  region = "eu-west-1"
}

// create 100 users
module "users" {
  source    = "./modules/cloudesk-user/"
  providers = {
    aws = aws
  }

  for_each = toset([
    for i in range(100) : format("user-%02d", i)
  ])
  name = each.key
}
