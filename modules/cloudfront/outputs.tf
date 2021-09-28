output "local-url" {
  value = "${var.url-prefix}.${var.application}"
}

output "cloudfront-id" {
  value = aws_cloudfront_distribution.application.id
}

output "cloudfront-arn" {
  value = aws_cloudfront_distribution.application.arn
}

output "cloudfront-caller-reference" {
  value = aws_cloudfront_distribution.application.caller_reference
}

output "cloudfront-status" {
  value = aws_cloudfront_distribution.application.status
}

output "cloudfront-etag" {
  value = aws_cloudfront_distribution.application.etag
}

output "cloudfront-hosted-zone-id" {
  value = aws_cloudfront_distribution.application.hosted_zone_id
}

output "orgin-access-identity-id" {
  value = aws_cloudfront_origin_access_identity.access-origin.id
}

output "orgin-access-identity-arn" {
  value = aws_cloudfront_origin_access_identity.access-origin.iam_arn
}

output "orgin-access-identity-s3-user-id" {
  value = aws_cloudfront_origin_access_identity.access-origin.s3_canonical_user_id
}