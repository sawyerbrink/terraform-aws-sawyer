data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_acm_certificate" "ui-cert" {
  domain   = "ui.${var.domain}"
  statuses = ["ISSUED"]
}