variable "profile" {
  description = "The AWS configuration profile to use"
}

variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "name" {
  type        = string
  description = "The global name of the owner. This could be a company, owning team, or area name. A default name will be provided if not specified."
  default     = ""
}

variable "sawyer-version" {
  type        = string
  description = "The version of sawyer to use"
  default     = "latest"
}

variable "tags" {
  type        = map(any)
  description = "A map of commonly used tags"
}

variable "kms-key-arn" {
  type = string
  description = "The KMS arn to use for encryption"
}

variable "backendinfra-support-sns-topic" {
  type        = string
  description = "The SNS topic to leverage for support purposes"
}

variable "backendinfra-api-name" {
  type = string
}

variable "backendinfra-api-description" {
  type = string
}

variable "backendinfra-environment" {
  type        = string
  description = "The environment for the infrastrcutrue (dev, test, prod)"
}

variable "backendinfra-api-version" {
  type        = string
  description = "The version of the API"
}

variable "backendinfra-api-stage-name" {
  type = string
}

variable "backendinfra-protocol-type" {
  type = string
}

variable "backendinfra-api-stage-auto-deploy" {
  type = bool
}

variable "backendinfra-security-policy" {
  type        = string
  description = "The TLS policy to apply to the API Gateway domain"
}

variable "backendinfra-passthrough-behavior" {
  type = string
}

variable "backendinfra-tracing-mode" {
  type = string
}

variable "backendinfra-route-timeout" {
  type = number
}

variable "backendinfra-access-log-format" {
  type = string
}

variable "backendinfra-cors-allow-origins" {
  type = list(any)
}

variable "backendinfra-cors-allow-headers" {
  type = list(any)
}

variable "backendinfra-cors-allow-methods" {
  type = list(any)
}

variable "backendinfra-cors-expose-headers" {
  type = list(any)
}

variable "backendinfra-sawyerbrink-ns" {
  type = list(any)
}

variable "backendinfra-sawyerbrink-soa" {
  type = string
}

variable "backendinfra-domain-name" {
  type = string
}

variable "backendinfra-api-domain-name" {
  type = string
}

variable "backendinfra-auth-domain" {
  type = string
}

variable "backendinfra-newslitapi-parameter-name" {
  type = string
}

variable "backendinfra-dynamodb-billing-mode" {
  type        = string
  description = "The DynomoDB billing mode to use"
  default     = "PAY_PER_REQUEST"
}

variable "backendinfra-dynamodb-provisioning-read-capacity" {
  type        = number
  description = "The read capacity to allocated"
  default     = 6
}

variable "backendinfra-dynamodb-provisioning-write-capacity" {
  type        = number
  description = "The write capacity to allocated"
  default     = 10
}

variable "backendinfra-dynamodb-point-in-recovery" {
  type        = bool
  description = "Enable/Disable DynamoDB point in time recovery"
}

variable "backendinfra-dynamodb-stream" {
  type        = bool
  description = "Enable/disable DynamoDB streams"
  default     = false
}

variable "backendinfra-dynamodb-gsi-provisioning-read-capacity" {
  type        = number
  description = "The read capacity to allocated for GSI"
  default = 10
}

variable "backendinfra-dynamodb-gsi-provisioning-write-capacity" {
  type        = number
  description = "The write capacity to allocated for GSI"
  default = 4
}


variable "backendinfra-lambda-sqs-index-document-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
}

variable "backendinfra-lambda-sqs-logging-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
}

variable "backendinfra-risk-sensing-image-version" {
  type        = string
  description = "The version for the risk-sensing image to use"
}

variable "backendinfra-batch-cpu" {
  type        = number
  description = "The number of CPUs to allocated for the batch job"
}

variable "backendinfra-batch-memory" {
  type        = number
  description = "The memory size to allocated for the batch job"
}

variable "backendinfra-fargate-version" {
  type        = string
  description = "The AWS Fargate version to use for batch jobs."
}

variable "backendinfra-rds-read-role" {
  type        = string
  description = "The read role for the RDS postgres database"
}

variable "backendinfra-rds-write-role" {
  type        = string
  description = "The write role for the RDS postgres database"
}

variable "backendinfra-rds-db-name" {
  type        = string
  description = "The DB name"
}

variable "backendinfra-rds-db-port" {
  type        = number
  description = "The RDS port that accepts network traffic."
}

variable "backendinfra-rds-postgres-engine-version" {
  type        = string
  description = "The RDS postgres engine version to use."
}

variable "backendinfra-rds-postgres-engine" {
  type        = string
  description = "The RDS postgres engine to utilize"
}

variable "backendinfra-disable-default-endpoint" {
  type        = bool
  default     = true
  description = "Disable API Gateway default HTTP endpoint"
}

variable "backendinfra-authorizer-type" {
  type        = string
  default     = "JWT"
  description = "The default authentication type for API Gateway"
  validation {
    condition     = can(regex("JWT|IAM", var.backend-authorizer-type))
    error_message = "ERROR: API Gateway authorizer type must be either JWT or IAM."
  }
}

variable "backendinfra-batch-state" {
  type        = string
  default     = "ENABLED"
  description = "Enable the AWS Batch compute environment"
}

variable "backendinfra-batch-type" {
  type        = string
  default     = "MANAGED"
  description = "Specify if a compute environment is managed by AWS or manually"
}

variable "backendinfra-batch-max-cpus" {
  type        = number
  default     = 16
  description = "The maximum number of CPUs to allocate for the Batch compute environment"
}

variable "backendinfra-batch-compute-type" {
  type        = string
  default     = "FARGATE_SPOT"
  description = "The type of the Batch compute environment"
}

variable "backendinfra-batch-retry-attempts" {
  type        = number
  default     = 1
  description = "The number of times to retry the Batch job"
}

variable "backendinfra-ecr-image-tag-mutability" {
  type = string
  description = "Mutability setting for the ECR generated repository"
  defdefault = "MUTABLE"  
}

locals {
  name = var.name != "" ? var.name : random_string.id.result
}
