resource "aws_route53_record" "api-alias" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.api-domain-name
  type    = "A"

  alias {
    name                   = aws_apigatewayv2_domain_name.api-sawyerbrink.domain_name_configuration.0.target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.api-sawyerbrink.domain_name_configuration.0.hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [aws_apigatewayv2_domain_name.api-sawyerbrink]
}