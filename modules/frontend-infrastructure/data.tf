data "aws_acm_certificate" "ui-cert" {
  domain   = "ui.${var.domain}"
  statuses = ["ISSUED"]
}

data "aws_route53_zone" "hosted_zone" {
  name = var.domain
}