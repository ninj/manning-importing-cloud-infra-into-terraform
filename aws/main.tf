terraform {
  required_version = ">= 0.13.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "1.0.0"
    }
  }

  backend "s3" {
    bucket = "importing-cloud-infrastructure-m4"
    key    = "aws/terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "users" {
  source = "../modules/cloudesk-user"

  for_each = toset([
    for i in range(10) : format("aws-%02d", i)
  ])

  name = each.key

  providers = {
    aws = aws
  }
}

output "aws_users" {
  value = module.users
}
