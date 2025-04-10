terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.54.0, < 5.0.0" # 4.54.0 at least is required for proper AWS SSO support, see #626
    }
  }
}
provider "aws" {
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  default_tags {
    tags = {
      StratusRedTeam = true
    }
  }
}

locals {
  resource_prefix = "stratus-red-team-backdoor-u"
}

resource "aws_iam_user" "legit-user" {
  name          = "${local.resource_prefix}-user" # TODO parametrize
  force_destroy = true
}

output "user_name" {
  value = aws_iam_user.legit-user.name
}

output "display" {
  value = format("IAM user %s ready", aws_iam_user.legit-user.name)
}