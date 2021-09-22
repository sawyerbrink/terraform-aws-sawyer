#############################
# API Domain Certificate
############################
resource "aws_acm_certificate" "api-cert" {
  domain_name = var.backendinfra-api-domain-name
  # subject_alternative_names = []
  validation_method = "DNS"

  tags = merge({ "Name" = var.backendinfra-api-domain-name }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "api_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.api-cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.primary.zone_id
    }
  }


  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}


resource "aws_acm_certificate_validation" "cert-1" {
  certificate_arn         = aws_acm_certificate.api-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.api_cert_validation : record.fqdn]

  timeouts {
    create = "20m"
  }
}