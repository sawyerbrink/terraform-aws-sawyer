data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_route53_zone" "primary" {
  name         = var.api-domain-name
  private_zone = false
}