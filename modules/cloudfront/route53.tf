resource "aws_route53_record" "cloudfront-record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "${var.url-prefix}.${var.application}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.application.domain_name
    zone_id                = aws_cloudfront_distribution.application.hosted_zone_id
    evaluate_target_health = false
  }
}
