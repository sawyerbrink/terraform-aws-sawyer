variable "application" {
  type        = string
  description = "Application name - DO NOT USE SPACES. This will be the url of that the end user will use to interact with Sawyer."
}

variable "bucket-name" {
  type        = string
  description = "The name of the bucket that contains the source code"
}


variable "bucket-dr-name" {
  type        = string
  description = "The name of the disater recovery bucket that contains the source code"
}

variable "s3-replication-role-arn" {
  type        = string
  description = "The S3 replication role to apply to the generated bucket policies"
}


variable "price-class" {
  type        = string
  description = "The CloudFront price class to apply"
  default     = "PriceClass_100"
}

variable "cache_items" {
  type        = list(string)
  description = "File glob patterns to be cached in CloudFront"
  default     = []
}

variable "root-document" {
  type        = string
  description = "Root document that will be the main entry point for the SPA"
  default     = "index.html"
}

variable "url-prefix" {
  type        = string
  description = "The url prfix to the website"
}

variable "error_document" {
  type        = string
  description = "Error document that will be used for an error page"
  default     = null
}

variable "custom_error_response" {
  type        = list(map(string))
  description = "Custom error responses"
}

variable "environment" {
  type        = string
  description = "The environment to deploy the application to"
}

variable "certificate-arn" {
  type        = string
  description = "The arn of the ACM certificate to apply to the CloudFront distribution."
}

variable "min_tls_version" {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
  default     = "TLSv1.2_2021"
}

variable "hosted-zone-name" {
  type        = string
  description = "The name of the route53 hosted zone that the SPA belongs to"
}

variable "web-acl-id" {
  type        = string
  description = "The ID of a WAF ACL to be applied"
  default     = null
}


locals {
  s3_origin_id       = "${var.bucket-name}-origin"
  s3_origin_dr_id    = "${var.bucket-dr-name}-origin"
  s3_origin_group_id = "saywerbrink-origin-group"
}