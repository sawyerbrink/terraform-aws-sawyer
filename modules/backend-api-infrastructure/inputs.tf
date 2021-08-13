variable "profile" {
  description = "The AWS configuration profile to use"
}

variable "support-sns-topic" {
  type        = string
  description = "The SNS topic to leverage for support purposes"
}

variable "api-name" {
  type = string
}

variable "api-description" {
  type = string
}

variable "environment" {
  type        = string
  description = "The environment for the infrastrcutrue (dev, test, prod)"
}

variable "api-version" {
  type        = string
  description = "The version of the API"
}

variable "api-stage-name" {
  type = string
}

variable "protocol-type" {
  type = string
}

variable "api-stage-auto-deploy" {
  type = bool
}

variable "security-policy" {
  type        = string
  description = "The TLS policy to apply to the API Gateway domain"
}

variable "tags" {
  type        = map(any)
  description = "A map of commonly used tags"
}

variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "passthrough-behavior" {
  type = string
}

variable "tracing-mode" {
  type = string
}

variable "route-timeout" {
  type = number
}

variable "access-log-format" {
  type = string
}

variable "cors-allow-origins" {
  type = list(any)
}

variable "cors-allow-headers" {
  type = list(any)
}

variable "cors-allow-methods" {
  type = list(any)
}

variable "cors-expose-headers" {
  type = list(any)
}

variable "sawyerbrink-ns" {
  type = list(any)
}

variable "sawyerbrink-soa" {
  type = string
}

variable "domain-name" {
  type = string
}

variable "api-domain-name" {
  type = string
}

variable "auth-domain" {
  type = string
}

variable "newslitapi-parameter-name" {
  type = string
}

variable "lambda-sqs-index-document-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
}

variable "lambda-sqs-logging-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
}

variable "risk-sensing-image-version" {
  type        = string
  description = "The version for the risk-sensing image to use"
}

variable "batch-cpu" {
  type        = number
  description = "The number of CPUs to allocated for the batch job"
}

variable "batch-memory" {
  type        = number
  description = "The memory size to allocated for the batch job"
}

variable "fargate-version" {
  type        = string
  description = "The AWS Fargate version to use for batch jobs."
}

variable "rds-read-role" {
  type        = string
  description = "The read role for the RDS postgres database"
}

variable "rds-write-role" {
  type        = string
  description = "The write role for the RDS postgres database"
}

variable "rds-db-name" {
  type        = string
  description = "The DB name"
}

variable "rds-db-port" {
  type        = number
  description = "The RDS port that accepts network traffic."
}

variable "rds-postgres-engine-version" {
  type        = string
  description = "The RDS postgres engine version to use."
}

variable "rds-postgres-engine" {
  type        = string
  description = "The RDS postgres engine to utilize"
}

variable "sawyer-version" {
  type        = string
  description = "The version of sawyer to use"
  default     = "latest"
}

locals {
  codeBucket       = "${var.domain-name}-${var.environment}-${data.aws_region.current.name}"
  image            = "https://github.com/sawyerbrink/sawyer/pkgs/container/sawyer/risk-sensing:${var.sawyer-version}"
  signedSourceList = data.aws_s3_bucket_objects.signedLambdas.keys
  sourceHashList   = data.aws_s3_bucket_object.object_info.*.metadata
  sourceHashMap    = zipmap(local.signedSourceList, local.sourceHashList)
}