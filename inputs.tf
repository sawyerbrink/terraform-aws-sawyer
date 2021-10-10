variable "profile" {
  description = "The AWS configuration profile to use"
}

variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "dr-region" {
  type        = string
  description = "The AWS disaster region to use"
}

variable "name" {
  type        = string
  description = "The global name of the owner. This could be a company, owning team, or area name. A default name will be provided if not specified."
  default     = ""
}

variable "org-name" {
  type        = string
  description = "The name of the organization"
}

variable "org-email-domain" {
  type        = string
  description = "The email domain of the organization"
}

variable "org-industry" {
  type        = string
  description = "The industry of the organization"
  default     = "NONE"
}

variable "org-size" {
  type        = string
  description = "The employee size of the organization"
  default     = "42"
}


variable "sawyer-version" {
  type        = string
  description = "The version of sawyer to use"
}

variable "newslit-api-key" {
  type        = string
  description = "The Newslit API Key value"
}

variable "logs-retention" {
  type        = number
  description = "The number of days to retain logs"
  default     = 3
}

variable "tags" {
  type        = map(any)
  description = "A map of commonly used tags"
}

variable "kms-key-arn" {
  type        = string
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
  type    = string
  default = "The Saywer API for risk and governance management"
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
  type    = string
  default = "default"
}

variable "backendinfra-protocol-type" {
  type        = string
  description = "The API Gateway Protocol"
  default     = "HTTP"
}

variable "backendinfra-api-stage-auto-deploy" {
  type    = bool
  default = true
}

variable "backendinfra-security-policy" {
  type        = string
  description = "The TLS policy to apply to the API Gateway domain"
}

variable "backendinfra-passthrough-behavior" {
  type        = string
  description = "The API Gateway Passthough behavior"
  default     = "WHEN_NO_MATCH"
}

variable "backendinfra-tracing-mode" {
  type        = string
  description = "The API Gateway tracing to enable"
  default     = "Active"
}

variable "backendinfra-route-timeout" {
  type    = number
  default = 29000
}

variable "backendinfra-access-log-format" {
  type    = string
  default = "{ \"ApiId\": \"$context.apiId\" , \"requestId\":\"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"userName\": \"$context.authorizer.claims.username\", \"authorizerError\": \"$context.authorizer.error\", \"authorizerLatency\": \"$context.authorizer.latency\", \"authorizerStatus\": \"$context.authorizer.status\", \"requestTime\":\"$context.requestTime\",\"httpMethod\":\"$context.httpMethod\",\"userAgent\":\"$context.identity.userAgent\",\"routeKey\":\"$context.routeKey\",\"path\":\"$context.path\",\"stage\":\"$context.stage\", \"status\":\"$context.status\", \"intergrationLatency\": \"$context.integrationLatency\", \"responseLatency\": \"$context.responseLatency\", \"protocol\":\"$context.protocol\", \"responseLength\":\"$context.responseLength\", \"domainName\": \"$context.domainName \",\"errorMessage\": \"$context.error.message\", \"integrationErrorMessage\": \"$context.integrationErrorMessage\"}"
}

variable "backendinfra-cors-allow-origins" {
  type    = list(any)
  default = ["*"]
}

variable "backendinfra-cors-allow-headers" {
  type    = list(any)
  default = ["*"]
}

variable "backendinfra-cors-allow-methods" {
  type    = list(any)
  default = ["GET", "PUT", "POST", "DELETE", "OPTIONS"]
}

variable "backendinfra-cors-expose-headers" {
  type    = list(any)
  default = ["*"]
}

variable "backendinfra-domain-name" {
  type = string
}

variable "backendinfra-api-domain-name" {
  type = string
}

variable "backendinfra-auth-domain" {
  type    = string
  default = ""
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
  default     = false
}

variable "backendinfra-dynamodb-stream" {
  type        = bool
  description = "Enable/disable DynamoDB streams"
  default     = false
}

variable "backendinfra-dynamodb-gsi-provisioning-read-capacity" {
  type        = number
  description = "The read capacity to allocated for GSI"
  default     = 10
}

variable "backendinfra-dynamodb-gsi-provisioning-write-capacity" {
  type        = number
  description = "The write capacity to allocated for GSI"
  default     = 4
}


variable "backendinfra-lambda-sqs-index-document-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
  default     = 10
}

variable "backendinfra-lambda-sqs-logging-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
  default     = 10
}

variable "backendinfra-risk-sensing-image-version" {
  type        = string
  description = "The version for the risk-sensing image to use"
  default     = "latest"
}

variable "backendinfra-batch-cpu" {
  type        = string
  description = "The number of CPUs to allocated for the batch job"
  default     = "2"
}

variable "backendinfra-batch-memory" {
  type        = string
  description = "The memory size to allocated for the batch job"
  default     = "6144"
}

variable "backendinfra-fargate-version" {
  type        = string
  description = "The AWS Fargate version to use for batch jobs."
  default     = "1.4.0"
}

variable "backendinfra-rds-read-role" {
  type        = string
  description = "The read role for the RDS postgres database"
  default     = "app_read_role"
}

variable "backendinfra-rds-write-role" {
  type        = string
  description = "The write role for the RDS postgres database"
  default     = "app_write_role"
}

variable "backendinfra-rds-db-name" {
  type        = string
  description = "The DB name"
  default     = "sawyer"
}

variable "backendinfra-ds-db-master-password" {
  type        = string
  description = "The RDS DB master password"
  default     = ""
}

variable "backendinfra-rds-db-port" {
  type        = number
  description = "The RDS port that accepts network traffic."
  default     = 5432
}

variable "backendinfra-rds-backup-retention-period" {
  type        = number
  description = "The number of days to retain an RDS backup"
  default     = 7
}

variable "backendinfra-rds-apply-immediately" {
  type        = bool
  description = "Apply RDS changes immediately"
  default     = false
}

variable "backendinfra-rds-enable-public-ip" {
  type        = bool
  description = "Toggle a public IP to the RDS cluster"
  default     = false
}

variable "backendinfra-rds-maintenance-window" {
  type        = string
  description = "The RDS maintenance to apply minor/major changes to."
  default     = "Fri:23:00-Sat:02:00"
}

variable "backendinfra-rds-preferred-backup-window" {
  type        = string
  description = "The prefered window for RDS to create backup snapshots"
  default     = "02:15-03:00"
}

variable "backendinfra-rds-delete-protection" {
  type        = bool
  description = "Enable RDS deletion protection"
  default     = false
}

variable "backendinfra-rds-az-list" {
  type        = list(string)
  description = "A list of availability zones to deploy RDS into."
  default     = []

}

variable "backendinfra-rds-instances" {
  type        = number
  description = "The number of RDS instances to deploy"
  default     = 1
}


variable "backendinfra-rds-db-subnet-name" {
  type        = string
  description = "The the name of the DB subnet"
}


variable "backendinfra-rds-postgres-engine-version" {
  type        = string
  description = "The RDS postgres engine version to use."
  default     = "12.4"
}

variable "backendinfra-rds-postgres-engine" {
  type        = string
  description = "The RDS postgres engine to utilize"
  default     = "aurora-postgresql"
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
  type        = string
  description = "Mutability setting for the ECR generated repository"
  default     = "MUTABLE"
}

variable "lambda-repository-region" {
  type = string
  validation {
    condition     = can(regex("us-east-1|us-west-2", var.lambda-repository-region))
    error_message = "ERROR: Lambda repository is only available in us-east-1 or us-west-2."
  }
}

variable "frontendinfra-min-tls-version" {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections"
  default     = "TLSv1.2_2021"
}

variable "website-repository-region" {
  type = string
  validation {
    condition     = can(regex("us-east-1|us-west-2", var.website-repository-region))
    error_message = "ERROR: Website repository is only available in us-east-1 or us-west-2."
  }
}

variable "lambda-publish" {
  type        = bool
  description = "Setting to enable Lambda publishing"
  default     = true
}

variable "backendinfra-private-subnet-ids" {
  type        = list(string)
  description = "A list of private subnet ids"
}

variable "backendinfra-security-group-ids" {
  type        = list(string)
  description = "A list of security group ids"
}

variable "backendinfra-iam-kms-grant-policy" {
  type        = string
  description = "IAM policy that grants access to KMS key."
  default     = ""
}

variable "backendinfra-vpc-id" {
  type        = string
  description = "The VPC ID to deploy Sawyer resources into."
}

variable "backendinfra-db-subnets-ids" {
  type        = list(string)
  description = "The ids of subnets that are to be used for RDS"
}

variable "backendinfra-rds-instance-size" {
  type        = string
  description = "The Amazon Aurora instance size to use"
  default     = "db.t3.medium"
}

variable "backendinfra-s3-force-destroy" {
  type        = bool
  description = "Enable S3 Force destroy"
  default     = false
}

variable "ses-email-arn" {
  type        = string
  description = "The ARN of the SES email to utilize. If empty the default Cognito email will be used."
  default     = ""
}

variable "backendinfra-api-certificate-arn" {
  type        = string
  description = "The AWS ACM certificate arn for API Gateway to utilize for HTTPS"
}


variable "backendinfra-lambda-security-groups-ids" {
  type        = list(string)
  description = "A list of security groups to apply to all Sawyer Lambdas"
  default     = []
}

variable "backendinfra-lambda-subnet-ids" {
  type        = list(string)
  description = "A list of subnet ids to associate Lambdas with. Required for accessing RDS"
  default     = []
}

variable "backendinfra-enable-audit-logging" {
  type        = bool
  description = "Enable audit logging"
  default     = true
}

variable "website-build-lambda-memory-size" {
  type = number
  description = "The memory size of the Lambda that builds the website assets"
  default = 512
}

locals {
  name               = var.name != "" ? var.name : random_string.id.result
  db-master-password = var.backendinfra-ds-db-master-password != "" ? var.backendinfra-ds-db-master-password : random_password.db-password.result
  orgId              = "o${formatdate("05040302012006", timestamp())}${substr(uuidv5("6ba7b810-9dad-11d1-80b4-00c04fd430c8", var.name), 0, 8)}"

  account_id = data.aws_caller_identity.current
}
