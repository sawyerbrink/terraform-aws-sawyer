data "aws_iam_role" "admin-role" {
  name = "administrator"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_route53_zone" "primary" {
  name         = var.backendinfra-api-domain-name
  private_zone = false
}
