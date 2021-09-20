resource "aws_lambda_function" "lambda" {

  s3_bucket = var.s3-bucket-name
  s3_key    = var.s3-key

  function_name                  = var.function-name
  role                           = var.function-role-arn
  handler                        = var.handler
  runtime                        = var.runtime
  description                    = var.description
  timeout                        = var.timeout
  memory_size                    = var.memory-size
  source_code_hash               = var.source-code-hash
  publish                        = var.publish
  kms_key_arn                    = var.kms-key-arn-lambda
  layers                         = var.layers
  reserved_concurrent_executions = var.reserved-concurrent-executions

  code_signing_config_arn = var.code-signing-config-arn

  environment {
    variables = var.environment
  }

  # dead_letter_config {
  #   target_arn = var.dlq-target-arn
  # }

  tracing_config {
    mode = var.tracing-mode
  }

  vpc_config {
    subnet_ids         = var.subnet-ids
    security_group_ids = var.security-groups-ids
  }
  tags = var.tags
}

resource "aws_lambda_alias" "lambda-alias" {
  name             = var.alias
  description      = var.alias-description
  function_name    = aws_lambda_function.lambda.arn
  function_version = aws_lambda_function.lambda.version
  depends_on       = [aws_lambda_function.lambda]
}

resource "aws_lambda_permission" "lambda-permission" {
  statement_id  = "AllowAPIInvoke-${var.function-name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_alias.lambda-alias.function_name
  principal     = "apigateway.amazonaws.com"
  qualifier     = aws_lambda_alias.lambda-alias.name

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = var.api-source-arn

}

resource "aws_cloudwatch_log_group" "lambda-cloudwatch-group" {
  name              = "/aws/lambda/${var.function-name}"
  retention_in_days = var.logs-retention
  tags              = var.tags
  kms_key_id        = var.kms-key-arn-cloudwatch
}

resource "aws_lambda_function_event_invoke_config" "invoke-settings" {
  function_name                = aws_lambda_alias.lambda-alias.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
}