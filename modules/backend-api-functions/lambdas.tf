################################
# Lambdas
################################
module "lambdas" {
  for_each = var.lambda-functions
  ##################
  # Global Settings
  #################
  source                 = "../lambda-apigateway"
  s3-bucket-name         = local.codeBucket
  alias                  = var.lambda-alias
  alias-description      = "Integrates with the ${each.key} Lambda"
  function-role-arn      = var.main-lambda-role-arn
  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))

  environment = {
    REGION        = var.region
    TABLE_NAME    = var.dynamodb-table-id
    QUEUE_URL     = var.audit-sqs-url
    API_URL       = "${var.environment}.api.sawyerbrink.com/v${var.api-version}"
    DB_NAME       = "sawyer"
    DB_USER       = each.value.dbUser
    DB_HOST       = var.rds-reader-endpoint
    DB_PORT       = var.rds-access-port
    AUDIT_LOGGING = var.enable-audit-logging
  }

  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/${var.apigateway-routes[each.key].route-method}/v${var.api-version}${var.apigateway-routes[each.key].route-key}"
  ############################
  # Lambda Specific Settings
  ############################
  s3-key = "${lower(var.sawyer-version)}/${each.value.s3-key}"


  description         = each.value.description
  function-name       = each.value.function-name
  handler             = each.value.handler
  runtime             = each.value.lambda-runtime
  timeout             = each.value.lambda-timeout
  memory-size         = each.value.lambda-memory-size
  publish             = each.value.lambda-publish
  security-groups-ids = each.value.vpc == true ? var.lambda-security-groups-ids : []
  subnet-ids          = each.value.vpc == true ? var.lambda-subnet-ids : []
  ####################
  # Dependencies
  ###################
}
#########################################################
# Custom Lambdas
#########################################################
# Lambdas - GET getLogs
#############################
module "getLogs-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/getLogs.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the getLogs lambda"
  description       = "A lambda function that returns the daily log summary"
  function-name     = "getLogs"
  function-role-arn = var.apigateway-s3-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode

  environment = {
    BUCKET_NAME = var.audit-logging-bucket
    REGION      = var.region
  }


  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/GET/v${var.api-version}/logs"

}

#############################
# Lambdas - pollSQS
#############################
resource "aws_lambda_function" "pollsqs-lambda" {
  s3_bucket     = local.codeBucket
  s3_key        = "${lower(var.sawyer-version)}/pollSQS.zip"
  function_name = "pollSQS"
  role          = var.lambda-sqs-role-arn
  handler       = var.lambda-handler
  runtime       = var.lambda-runtime
  description   = "A lambda function that pulls messages from SQS and stores them in an S3 bucket"
  timeout       = var.lambda-timeout
  memory_size   = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source_code_hash               = base64encode(lower(var.sawyer-version))
  publish                        = var.lambda-publish
  reserved_concurrent_executions = var.lambda-sqs-index-document-concurrency-limit


  environment {
    variables = {
      REGION     = var.region
      QUEUE_URL  = var.audit-sqs-url
      LOG_BUCKET = var.audit-logging-bucket
    }

  }

  tracing_config {
    mode = "Active"
  }


}

resource "aws_lambda_alias" "pollsqs-lambda-alias" {
  name             = upper(var.environment)
  description      = "Alias for the pollsqs lambda"
  function_name    = aws_lambda_function.pollsqs-lambda.arn
  function_version = aws_lambda_function.pollsqs-lambda.version
  depends_on       = [aws_lambda_function.pollsqs-lambda]
}

resource "aws_lambda_function_event_invoke_config" "pollsqs-lambda-invoke-settings" {
  function_name                = aws_lambda_alias.pollsqs-lambda-alias.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
}

resource "aws_lambda_event_source_mapping" "pollsqs-lambda-mapping" {
  event_source_arn = var.audits-queue-arn
  function_name    = aws_lambda_function.pollsqs-lambda.arn
  batch_size       = 10
  enabled          = true
  depends_on       = [aws_lambda_function.pollsqs-lambda]
}


resource "aws_cloudwatch_log_group" "pollsqs-lambda-cloudwatch-group" {
  name              = "/aws/lambda/pollSQS"
  retention_in_days = var.lambda-logs-retention

  kms_key_id = var.kms-key-arn
}

#############################
# Lambdas - Log Aggregator
#############################
resource "aws_lambda_function" "log-aggregator-lambda" {
  s3_bucket     = local.codeBucket
  s3_key        = "${lower(var.sawyer-version)}/logAggregator.zip"
  function_name = "logAggregator"
  role          = var.lambda-s3-role-arn
  handler       = var.lambda-handler
  runtime       = var.lambda-runtime
  description   = "A lambda function that reads the auditing log bucket and creates a daily summary JSON file"
  timeout       = 60
  memory_size   = 256
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source_code_hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish


  environment {
    variables = {
      REGION      = var.region
      BUCKET_NAME = var.audit-logging-bucket
    }

  }

  tracing_config {
    mode = "Active"
  }


}

resource "aws_lambda_alias" "log-aggregator-lambda-alias" {
  name             = upper(var.environment)
  description      = "Alias for the log-aggregator lambda"
  function_name    = aws_lambda_function.log-aggregator-lambda.arn
  function_version = aws_lambda_function.log-aggregator-lambda.version
  depends_on       = [aws_lambda_function.log-aggregator-lambda]
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_log-aggregator-lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.log-aggregator-lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.log-aggregator.arn
  qualifier     = aws_lambda_alias.log-aggregator-lambda-alias.name
}

resource "aws_cloudwatch_log_group" "log-aggregator-lambda-cloudwatch-group" {
  name              = "/aws/lambda/logAggregator"
  retention_in_days = var.lambda-logs-retention

  kms_key_id = var.kms-key-arn
}

##############################
# Lambdas - Trigger AWS Batch
##############################
resource "aws_lambda_function" "trigger-aws-batch" {
  s3_bucket     = local.codeBucket
  s3_key        = "${lower(var.sawyer-version)}/triggerBatch.zip"
  function_name = "triggerBatch"
  role          = var.lambda-batch-trigger-role-arn
  handler       = var.lambda-handler
  runtime       = var.lambda-runtime
  description   = "A lambda function that triggers the Risk Sensing batch job."
  timeout       = 15
  memory_size   = 128
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source_code_hash = base64encode(lower(var.sawyer-version))
  publish          = true


  environment {
    variables = {
      REGION         = var.region
      JOB_QUEUE      = var.batch-compute-queue-arn
      JOB_DEFINITION = var.batch-job-definition-arn
      SNS_TOPIC_ARN  = var.sns-topic-arn
    }

  }

  tracing_config {
    mode = "Active"
  }

}

resource "aws_lambda_alias" "trigger-aws-batch-lambda-alias" {
  name             = upper(var.environment)
  description      = "Alias for the triggerBatch lambda"
  function_name    = aws_lambda_function.trigger-aws-batch.arn
  function_version = aws_lambda_function.trigger-aws-batch.version
  depends_on       = [aws_lambda_function.trigger-aws-batch]
}

resource "aws_lambda_function_event_invoke_config" "trigger-aws-batch-lambda-alias-retry-setting" {
  function_name                = aws_lambda_alias.trigger-aws-batch-lambda-alias.function_name
  qualifier                    = aws_lambda_alias.trigger-aws-batch-lambda-alias.name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_batch_lambda-morning" {
  statement_id  = "AllowExecutionFromCloudWatchMorning"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trigger-aws-batch.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.batch-trigger.arn
  qualifier     = aws_lambda_alias.trigger-aws-batch-lambda-alias.name
}

resource "aws_cloudwatch_log_group" "trigger-aws-batch-lambda-cloudwatch-group" {
  name              = "/aws/lambda/triggerBatch"
  retention_in_days = var.lambda-logs-retention

  kms_key_id = var.kms-key-arn
}

#############################
# Lambdas - DELETE Audit
#############################
module "deleteAudit-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/deleteAudit.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the deleteAudit lambda"
  description       = "A lambda function that deltes an audit unit"
  function-name     = "deleteAudit"
  function-role-arn = var.lambda-delete-audits-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode
  security-groups-ids    = var.lambda-security-groups-ids
  subnet-ids             = var.lambda-subnet-ids


  environment = {
    REGION        = var.region
    QUEUE_URL     = var.audit-sqs-url
    DB_NAME       = var.rds-table-name
    DB_USER       = var.rds-write-role
    DB_HOST       = var.rds-reader-endpoint
    DB_PORT       = var.rds-access-port
    AUDIT_LOGGING = var.enable-audit-logging
  }



  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/DELETE/v${var.api-version}/audits/{audit_id}"


}

#############################
# Lambdas - DELETE control
#############################
module "deleteControl-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/deleteControl.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the deleteControl lambda"
  description       = "A lambda function for the PUT a specific control from DynamoDB and returns a JSON response"
  function-name     = "deleteControl"
  function-role-arn = var.lambda-delete-audits-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode
  security-groups-ids    = var.lambda-security-groups-ids
  subnet-ids             = var.lambda-subnet-ids

  environment = {
    REGION        = var.region
    QUEUE_URL     = var.audit-sqs-url
    DB_NAME       = var.rds-table-name
    DB_USER       = var.rds-write-role
    DB_HOST       = var.rds-reader-endpoint
    DB_PORT       = var.rds-access-port
    AUDIT_LOGGING = var.enable-audit-logging
  }


  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/DELETE/v${var.api-version}/controls/{control_id}"


}

#############################
# Lambdas - DELETE risk
#############################
module "deleteRisk-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/deleteRisk.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the deleteRisk lambda"
  description       = "A lambda function for the PUT a specific control from DynamoDB and returns a JSON response"
  function-name     = "deleteRisk"
  function-role-arn = var.lambda-delete-audits-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode
  security-groups-ids    = var.lambda-security-groups-ids
  subnet-ids             = var.lambda-subnet-ids

  environment = {
    REGION        = var.region
    QUEUE_URL     = var.audit-sqs-url
    DB_NAME       = var.rds-table-name
    DB_USER       = var.rds-write-role
    DB_HOST       = var.rds-reader-endpoint
    DB_PORT       = var.rds-access-port
    AUDIT_LOGGING = var.enable-audit-logging
  }



  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/DELETE/v${var.api-version}/risks/{risk_id}"


}

#############################
# Lambdas - getPresignedUrl 
#############################
module "getPresignedUrl-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/presignedUrl.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the presignedUrl lambda"
  description       = "A lambda function for getting a presigned-url"
  function-name     = "presignedUrl"
  function-role-arn = var.lambda-presigned_url-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode

  environment = {
    QUEUE_URL       = var.audit-sqs-url
    CUSTOMER_BUCKET = var.customer-documents-bucket
    REGION          = var.region
  }



  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/GET/v${var.api-version}/presigned-url"

}

#################################
# Lambdas - IndexDocument Lambda
#################################
resource "aws_lambda_function" "Index-document-lambda" {
  function_name = "indexDocument"
  s3_bucket     = local.codeBucket
  s3_key        = "${lower(var.sawyer-version)}/indexDocument.zip"
  role          = var.lambda-index-documents-role-arn
  handler       = var.lambda-handler
  runtime       = var.lambda-runtime
  description   = "A lambda function that pulls messages from SQS and index customers documents in DynamoDb"
  timeout       = 40
  memory_size   = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source_code_hash               = base64encode(lower(var.sawyer-version))
  publish                        = var.lambda-publish
  reserved_concurrent_executions = var.lambda-sqs-logging-concurrency-limit


  environment {
    variables = {
      DEAD_QUEUE = var.customer-documents-sqs-url
      REGION     = var.region
      TABLE_NAME = var.dynamodb-table-id
    }

  }

  tracing_config {
    mode = "Active"
  }


}

resource "aws_lambda_alias" "Index-document-lambda-alias" {
  name             = upper(var.environment)
  description      = "Alias for the Index-document-lambda"
  function_name    = aws_lambda_function.Index-document-lambda.function_name
  function_version = aws_lambda_function.Index-document-lambda.version
  depends_on       = [aws_lambda_function.Index-document-lambda]
}

resource "aws_lambda_event_source_mapping" "Index-document-lambda-mapping" {
  event_source_arn = var.customer-documents-queue-arn
  function_name    = aws_lambda_function.Index-document-lambda.arn
  batch_size       = 10
  enabled          = true
  depends_on       = [aws_lambda_function.Index-document-lambda]
}

resource "aws_lambda_function_event_invoke_config" "Index-document-lambda-invoke-settings" {
  function_name                = aws_lambda_alias.Index-document-lambda-alias.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
}


resource "aws_cloudwatch_log_group" "Index-document-lambda-cloudwatch-group" {
  name              = "/aws/lambda/IndexDocument"
  retention_in_days = var.lambda-logs-retention
  kms_key_id        = var.kms-key-arn
}

################################
# Lambdas - deleteAuditDocument 
################################
module "deleteAuditDocument-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/deleteAuditDocument.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the deleteAuditDocument lambda"
  description       = "A lambda function deletes a document belonging to an audit"
  function-name     = "deleteAuditDocument"
  function-role-arn = var.lambda-delete-audits-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  source-code-hash  = base64encode(lower(var.sawyer-version))
  publish           = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode

  environment = {
    QUEUE_URL       = var.audit-sqs-url
    CUSTOMER_BUCKET = var.customer-documents-bucket
    TABLE_NAME      = var.dynamodb-table-id
    REGION          = var.region
  }



  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/DELETE/v${var.api-version}/audits/{audit_id}/documents"


}

####################################
# Lambdas - deleteControlsDocuments 
####################################
module "deleteControlsDocuments-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/deleteControlsDocuments.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the deleteControlsDocuments lambda"
  description       = "A lambda function that deletes a document belonging to a control"
  function-name     = "deleteControlsDocuments"
  function-role-arn = var.lambda-delete-audits-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode

  environment = {
    QUEUE_URL       = var.audit-sqs-url
    CUSTOMER_BUCKET = var.customer-documents-bucket
    TABLE_NAME      = var.dynamodb-table-id
    REGION          = var.region
  }



  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/DELETE/v${var.api-version}/controls/{control_id}/documents"


}

####################################
# Lambdas - deleteRisksDocuments 
####################################
module "deleteRisksDocuments-lambda" {
  source         = "../lambda-apigateway"
  s3-bucket-name = local.codeBucket
  s3-key         = "${lower(var.sawyer-version)}/deleteRisksDocuments.zip"

  alias             = var.lambda-alias
  alias-description = "Alias for the deleteRisksDocuments lambda"
  description       = "A lambda function that deletes a document belonging to a risks"
  function-name     = "deleteRisksDocuments"
  function-role-arn = var.lambda-delete-audits-role-arn
  handler           = var.lambda-handler
  runtime           = var.lambda-runtime
  timeout           = var.lambda-timeout
  memory-size       = var.lambda-memory-size
  // This will always trigger an update due to the issue #7385 in the terraform-provider-aws
  source-code-hash = base64encode(lower(var.sawyer-version))
  publish          = var.lambda-publish

  logs-retention         = var.lambda-logs-retention
  kms-key-arn-cloudwatch = var.kms-key-arn
  tracing-mode           = var.tracing-mode

  environment = {
    QUEUE_URL       = var.audit-sqs-url
    CUSTOMER_BUCKET = var.customer-documents-bucket
    TABLE_NAME      = var.dynamodb-table-id
    REGION          = var.region
  }
  api-source-arn = "${var.api-execution-arn}/${var.api-stage-id}/DELETE/v${var.api-version}/risks/{risk_id}/documents"

}