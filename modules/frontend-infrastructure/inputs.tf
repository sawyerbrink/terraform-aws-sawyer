variable "url-prefix" {
  type        = string
  description = "The url prefix for the website"
  default     = "ui"
}

variable "name" {
  type        = string
  description = "Name prefix to use for infrastructure resources."
}

variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "dr-region" {
  type        = string
  description = "The AWS DR region to use"
}

variable "profile" {
  description = "The AWS configuration profile to use"
  default     = ""
}

variable "domain" {
  type = string
}

variable "kms-key-arn" {
  type        = string
  description = "The KMS arn to use for encryption"
}

variable "environment" {
  type        = string
  description = "The environment for the infrastrcutrue (dev, test, prod)"
}

variable "sawyer-version" {
  type        = string
  description = "The version of sawyer to use"
  default     = "1.0.0"
}

variable "website-repository-region" {
  type    = string
  default = "us-east-1"
}

variable "min-tls-version" {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
}

variable "cognito-userpool-id" {
  type        = string
  description = "The Cognito userpool id generated for Sawyer"
}

variable "cognito-userpool-client-id" {
  type        = string
  description = "The Cognito userpool web client id"
}

variable "website-build-lambda-memory-size" {
  type        = number
  description = "The memory size of the Lambda that builds the website assets"
  default     = 512
}