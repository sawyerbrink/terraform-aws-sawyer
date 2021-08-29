data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_route53_zone" "primary" {
  name         = var.api-domain-name
  private_zone = false
}

data "aws_acm_certificate" "api-cert" {
  domain   = var.api-domain-name
  statuses = ["ISSUED"]
}

data "aws_ssm_parameter" "db-password" {
  name            = "aurora-db-password"
  with_decryption = true
}
