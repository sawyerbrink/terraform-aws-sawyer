module "cloudfront" {
  source = "../cloudfront"


  providers = {
    aws    = aws
    aws.dr = aws.dr
  }

  bucket-name             = aws_s3_bucket.code-storage.id
  bucket-dr-name          = aws_s3_bucket.code-storage-DR.id
  s3-replication-role-arn = aws_iam_role.s3-replication.arn

  application = var.domain
  url-prefix  = var.url-prefix
  environment = var.environment

  min_tls_version = var.min-tls-version

  custom_error_response = [{
    "error_code" : "403",
    "response_code" : "200",
    "response_page_path" : "/",
    "error_caching_min_ttl" : "300"
  }]
  cache_items      = ["/static/*"]
  hosted-zone-name = var.domain
  certificate-arn  = data.aws_acm_certificate.ui-cert.arn

  error_document = "index.html"

  depends_on = [
    aws_s3_bucket.code-storage,
    aws_s3_bucket.code-storage-DR,
    aws_iam_role.s3-replication,
    local_file.s3-replication-config
  ]
}




