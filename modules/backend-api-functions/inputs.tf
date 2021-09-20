variable "sawyer-version" {
  type        = string
  description = "The version of sawyer to use"
}


variable "api-description" {
  type = string
}

variable "api-id" {
  type        = string
  description = "The ID of the API Gateway"
}

variable "api-execution-arn" {
  type        = string
  description = "The API Gateway execution arn"
}

variable "api-stage-id" {
  type        = string
  description = "The ID of the Api Gateway stage"
}

variable "environment" {
  type        = string
  description = "The environment for the infrastrcutrue (dev, test, prod)"
}

variable "api-version" {
  type        = string
  description = "The version of the API"
}

variable "region" {
  type        = string
  description = "The AWS region to use"
}

variable "lambda-alias" {
  type = string
  default = "default"
}

variable "lambda-handler" {
  type = string
  default = "main"
}

variable "lambda-runtime" {
  type = string
  default = "go1.x"
}

variable "lambda-timeout" {
  type = number
  default = 15
}

variable "lambda-memory-size" {
  type = number
  default = 128
}

variable "lambda-publish" {
  type = bool
  default = true
}

variable "lambda-logs-retention" {
  type = number
  description = "The number of days to retain Lambda logs"
  default = 3
}

variable "lambda-security-groups-ids" {
  type        = list(string)
  description = "A list of security groups to apply to all Sawyer Lambdas"
  default     = []
}

variable "lambda-subnet-ids" {
  type        = list(string)
  description = "A list of subnet ids to associate Lambdas with. Required for accessing RDS"
}

variable "lambda-s3-role-arn" {
  type        = string
  description = "The role arn of the Lambda S3 role"
}

variable "lambda-index-documents-role-arn" {
  type = string
  description = "The role arn of the Lambda that indexes documents and interacts with DynamoDB"
  
}

variable "lambda-presigned_url-role-arn" {
  type        = string
  description = "The role arn of the Lambda to use for generating presigned urls"
}

variable "lambda-delete-audits-role-arn" {
  type        = string
  description = "The role arn of the Lambda Api Gateway delete role"
}

variable "lambda-batch-trigger-role-arn" {
  type        = string
  description = "The role arn of the Lambda Batch trigger role"
}

variable "payload-format" {
  type = string
  default = "2.0"
}

variable "passthrough-behavior" {
  type = string
  default = "WHEN_NO_MATCH"
}

variable "tracing-mode" {
  type = string
  description = "The Lambda tracing mode"
  default = "Active"
}

variable "route-timeout" {
  type = number
  default = 29000
}

variable "authorizer-id" {
  type        = string
  description = "The default authorizer for the Api Gateway"
}

variable "authorization-type" {
  type = string
  default = "JWT"
}

variable "newslit-api-key" {
  type        = string
  description = "The API Key value for Newslit API"

}

variable "kms-key-arn" {
  type        = string
  description = "The KMS arn to use for encryption"
}

variable "lambda-repository-region" {
  type    = string
  default = "us-east-1"
}

variable "main-lambda-role-arn" {
  type        = string
  description = "The role arn of the main lambda role"
}

variable "lambda-sqs-role-arn" {
  type        = string
  description = "The role arn of the Lambda role that interactis with SQS queues"
}

variable "lambda-sqs-index-document-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
  default     = 10
}

variable "lambda-sqs-logging-concurrency-limit" {
  type        = number
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
  default     = 10
}

variable "dynamodb-table-id" {
  type        = string
  description = "The ID of the DynomoDB table"
}

variable "audit-sqs-url" {
  type        = string
  description = "The url of the audit SQS queue"
}

variable "customer-documents-sqs-url" {
  type        = string
  description = "The url of the customer documents SQS queue"
}

variable "rds-table-name" {
  type        = string
  description = "Name for the Database in RDS"
  default     = "sawyer"
}

variable "rds-read-role" {
  type        = string
  description = "Name for the rds write role in RDS"
  default     = "app_read_role"
}

variable "rds-write-role" {
  type        = string
  description = "Name for the rds write role in RDS"
  default     = "app_write_role"
}

variable "rds-access-port" {
  type        = number
  description = "Port for the Postgres RDS"
  default     = 5432
}

variable "rds-reader-endpoint" {
  type        = string
  description = "The RDS reader endpoint"
}

variable "log-aggregator-cron-rule" {
  type        = string
  description = "The default cron rule to trigger log aggregation. This will be 02:05 AM Arizona Time"
  default     = "cron(5 9 * * ? *)"
}

variable "batch-trigger-cron-rule" {
  type        = string
  description = "The default cron rule to trigger the risk-sensing batch job. Every other day at 5 AM PHX Time Zone"
  default     = "cron(0 10 */2 * ? *)"
}

variable "enable-audit-logging" {
  type        = bool
  description = "Enable audit logging"
  default     = true
}

variable "apigateway-s3-role-arn" {
  type        = string
  description = "This is the main role for Lambdas related to the API methods that can invoke S3 API functions"
}

variable "audits-queue-arn" {
  type = string
  description = "The arn of the audits sqs queue"
  
}

variable "customer-documents-queue-arn" {
  type = string
  description = "The arn of the customer documents sqs queue"
}

variable "audit-logging-bucket" {
  type        = string
  description = "The S3 id of the audit logging bucket"
}

variable "customer-documents-bucket" {
  type        = string
  description = "The customer documents bucket"
}

variable "batch-compute-queue-arn" {
  type        = string
  description = "The AWS Batch compute queue arn"
}

variable "batch-job-definition-arn" {
  type        = string
  description = "The AWS Batch job definition for the Risk Sensing job"
}

variable "sns-topic-arn" {
  type        = string
  description = "The SNS topic to report issues and other internal notifications related to Sawyer."
}

variable "cloudwatch-trigger-role-arn" {
  type        = string
  description = "The role arn of the Cloudwatch events trigger role"
}


locals {
  codeBucket = "sawyerbrink-lambda-binaries-${var.lambda-repository-region}"
}

variable "lambda-functions" {
  type = map(any)
  default = {
    "getOrganization" = {
      s3-key             = "getOrganization.zip"
      version            = "1.3.1"
      description        = "A lambda function the queries RDS and returns the JSON answer for the Organization resource"
      function-name      = "getOrganization"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "getAudits" = {
      s3-key             = "getAudits.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET Audits to DynamoDB and returns a JSON response"
      function-name      = "getAudits"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "getAuditsId" = {
      s3-key             = "getAuditsId.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET Audits/:id to DynamoDB and returns a JSON response"
      function-name      = "getAuditsId"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "postAudits" = {
      s3-key             = "postAudits.zip"
      version            = "1.3.1"
      description        = "A lambda function for the POST Audits to DynamoDB and returns a JSON response"
      function-name      = "postAudits"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_write_role"
      vpc                = true

    },
    "putAudits" = {
      s3-key             = "putAudits.zip"
      version            = "1.3.1"
      description        = "A lambda function for the PUT Audits to DynamoDB and returns a JSON response"
      function-name      = "putAudits"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_write_role"
      vpc                = true

    },
    "getAuditsRisks" = {
      s3-key             = "getAuditsRisks.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET Audit's risks to DynamoDB and returns a JSON response"
      function-name      = "getAuditsRisks"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "getAuditsControls" = {
      s3-key             = "getAuditsControls.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET Audit's controls to DynamoDB and returns a JSON response"
      function-name      = "getAuditsControls"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "postRisks" = {
      s3-key             = "postRisks.zip"
      version            = "1.3.1"
      description        = "A lambda function for the POST Audit's risks to DynamoDB and returns a JSON response"
      function-name      = "postRisks"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_write_role"
      vpc                = true

    },
    "getRisks" = {
      s3-key             = "getRisks.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET Audit's risks to DynamoDB and returns a JSON response"
      function-name      = "getRisks"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "getRisksId" = {
      s3-key             = "getRisksId.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET a specific risk from DynamoDB and returns a JSON response"
      function-name      = "getRisksId"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "getRisksControls" = {
      s3-key             = "getRisksControls.zip"
      version            = "1.3.1"
      description        = "A lambda function that queries all controls that belong to a specific risk from RDS and returns a JSON response"
      function-name      = "getRisksControls"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "putRisks" = {
      s3-key             = "putRisks.zip"
      version            = "1.3.1"
      description        = "A lambda function for the PUT of a specific risk from DynamoDB and returns a JSON response"
      function-name      = "putRisks"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_write_role"
      vpc                = true

    },
    "getControls" = {
      s3-key             = "getControls.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET all controls from DynamoDB and returns a JSON response"
      function-name      = "getControls"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "getControlsId" = {
      s3-key             = "getControlsId.zip"
      version            = "1.3.1"
      description        = "A lambda function for the GET a specific control from DynamoDB and returns a JSON response"
      function-name      = "getControlsId"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true

    },
    "putControls" = {
      s3-key             = "putControls.zip"
      version            = "1.3.1"
      description        = "A lambda function for the PUT a specific control from DynamoDB and returns a JSON response"
      function-name      = "putControls"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_write_role"
      vpc                = true

    },
    "postControls" = {
      s3-key             = "postControls.zip"
      version            = "1.3.1"
      description        = "A lambda function for the PUT a specific control from DynamoDB and returns a JSON response"
      function-name      = "postControls"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_write_role"
      vpc                = true

    },
    "getDocuments" = {
      s3-key             = "getDocuments.zip"
      version            = "1.3.1"
      description        = "A lambda function for getting a list of all of the organization's documents"
      function-name      = "getDocuments"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = ""
      vpc                = false

    },
    "getAuditsDocuments" = {
      s3-key             = "getAuditsDocuments.zip"
      version            = "1.3.1"
      description        = "A lambda function that returns all of an audit's documentss"
      function-name      = "getAuditsDocuments"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = ""
      vpc                = false

    },
    "getControlsDocuments" = {
      s3-key             = "getControlsDocuments.zip"
      version            = "1.3.1"
      description        = "A lambda function that returns all of a control's documents"
      function-name      = "getControlsDocuments"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = ""
      vpc                = false

    },
    "getRisksDocuments" = {
      s3-key             = "getRisksDocuments.zip"
      version            = "1.3.1"
      description        = "A lambda function that returns all of a risks's documents"
      function-name      = "getRisksDocuments"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = ""
      vpc                = false

    },
    "getAuditsRiskSensing" = {
      s3-key             = "getAuditsRiskSensing.zip"
      version            = "1.3.1"
      description        = "A lambda function that returns all risk-sensing units for an audit."
      function-name      = "getAuditsRiskSensing"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = ""
      vpc                = false

    },
    "getRiskSensing" = {
      s3-key             = "getRiskSensing.zip"
      version            = "1.3.1"
      description        = "A lambda function that returns the risk-sensing leadership board units for the organization."
      function-name      = "getRiskSensing"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = ""
      vpc                = false

    },
    "getAnalytics" = {
      s3-key             = "getAnalytics.zip"
      version            = "1.3.1"
      description        = "A lambda function that returns the basic analytics for an organization"
      function-name      = "getAnalytics"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true
    },
    "getCustomization" = {
      s3-key             = "getCustomization.zip"
      version            = "1.3.1"
      description        = "A lambda function that returns the customization settings for the organization."
      function-name      = "getCustomization"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_read_role"
      vpc                = true
    },
    "putCustomization" = {
      s3-key             = "putCustomization.zip"
      description        = "A lambda function that updates the customization settings for an organization."
      function-name      = "putCustomization"
      handler            = "main"
      lambda-runtime     = "go1.x"
      lambda-timeout     = 15
      lambda-memory-size = 128
      lambda-publish     = true
      dbUser             = "app_write_role"
      vpc                = true
    }
  }
}

variable "apigateway-routes" {
  type = map(any)
  default = {
    "getOrganization" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/organization"
    },
    "getAudits" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/audits"
    },
    "getAuditsId" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/audits/{audit_id}"
    },
    "postAudits" = {
      timeout      = 29000
      route-method = "POST"
      route-key    = "/audits"
    },
    "putAudits" = {
      timeout      = 29000
      route-method = "PUT"
      route-key    = "/audits/{audit_id}"
    },
    "getAuditsRisks" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/audits/{audit_id}/risks"
    },
    "getAuditsControls" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/audits/{audit_id}/controls"
    },
    "postRisks" = {
      timeout      = 29000
      route-method = "POST"
      route-key    = "/risks"
    },
    "getRisks" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/risks"
    },
    "getRisksId" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/risks/{risk_id}"
    },
    "getRisksControls" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/risks/{risk_id}/controls"
    },
    "putRisks" = {
      timeout      = 29000
      route-method = "PUT"
      route-key    = "/risks/{risk_id}"
    },
    "getControls" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/controls"
    },
    "getControlsId" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/controls/{control_id}"
    },
    "putControls" = {
      timeout      = 29000
      route-method = "PUT"
      route-key    = "/controls/{control_id}"
    },
    "postControls" = {
      timeout      = 29000
      route-method = "POST"
      route-key    = "/controls"
    },
    "getDocuments" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/documents"
    },
    "getAuditsDocuments" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/audits/{audit_id}/documents"
    },
    "getControlsDocuments" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/controls/{control_id}/documents"
    },
    "getRisksDocuments" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/risks/{risk_id}/documents"
    },
    "getAuditsRiskSensing" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/audits/{audit_id}/risk-sensing"
    },
    "getRiskSensing" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/risk-sensing"
    },
    "getAnalytics" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/analytics"
    },
    "getCustomization" = {
      timeout      = 29000
      route-method = "GET"
      route-key    = "/customization"
    },
    "putCustomization" = {
      timeout      = 29000
      route-method = "PUT"
      route-key    = "/customization/{customization_id}"
    }
  }
}


