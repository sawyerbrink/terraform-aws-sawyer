resource "aws_cloudfront_origin_access_identity" "access-origin" {
  comment = var.application
}

resource "aws_cloudfront_origin_access_identity" "access-origin-dr" {
  provider = aws.dr
  comment  = var.application
}

resource "aws_cloudfront_distribution" "application" {
  comment             = var.application
  enabled             = true
  price_class         = var.price-class
  is_ipv6_enabled     = true
  default_root_object = var.root-document
  aliases             = ["${var.url-prefix}.${var.application}"]
  web_acl_id          = var.web-acl-id


  dynamic "custom_error_response" {
    for_each = var.custom_error_response
    content {
      error_code            = lookup(custom_error_response.value, "error_code")
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", "300")
    }
  }

  origin_group {
    origin_id = local.s3_origin_group_id

    failover_criteria {
      status_codes = [500, 502, 503]
    }

    member {
      origin_id = local.s3_origin_id
    }

    member {
      origin_id = local.s3_origin_dr_id
    }
  }


  origin {
    domain_name = var.bucket-domain-dr-name
    origin_id   = local.s3_origin_dr_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.access-origin-dr.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = var.bucket-domain-name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.access-origin.cloudfront_access_identity_path
    }
  }


  viewer_certificate {
    acm_certificate_arn      = var.certificate-arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = var.min_tls_version
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id


    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  dynamic "ordered_cache_behavior" {
    for_each = toset(var.cache_items == null ? [] : var.cache_items)

    content {
      path_pattern     = ordered_cache_behavior.value
      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
      cached_methods   = ["GET", "HEAD"]
      target_origin_id = local.s3_origin_id

      forwarded_values {
        query_string = true

        cookies {
          forward = "none"
        }
      }

      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 0
      max_ttl                = 0
      compress               = true
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }

}

