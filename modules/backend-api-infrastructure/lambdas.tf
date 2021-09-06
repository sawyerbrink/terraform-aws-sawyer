resource "aws_lambda_function" "preSignUp-trigger" {
  s3_bucket     = local.codeBucket
  s3_key        = "${var.sawyer-version}/preSignUp.zip"
  function_name = "preSignUp"
  role          = aws_iam_role.lambda-role.arn
  handler       = "main"
  runtime       = "go1.x"
  description   = "A lambda function that verifies valid email domains for users signing up"
  timeout       = 30
  memory_size   = 128
  publish       = true

  environment {
    variables = {
      REGION      = var.region
      ENV         = var.environment
      API_VERSION = var.api-version
    }
  }
}

resource "aws_lambda_permission" "allow_Cognito" {
  statement_id  = "AllowExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.preSignUp-trigger.function_name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.user-pool.arn
  qualifier     = aws_lambda_alias.preSignUp-trigger-alias.name
}

resource "aws_lambda_alias" "preSignUp-trigger-alias" {
  name             = upper(var.environment)
  description      = "Alias for the preSignUp lambda"
  function_name    = aws_lambda_function.preSignUp-trigger.arn
  function_version = aws_lambda_function.preSignUp-trigger.version
  depends_on       = [aws_lambda_function.preSignUp-trigger]
}

resource "aws_lambda_function_event_invoke_config" "preSignUp-trigger-lambda-invoke-settings" {
  function_name                = aws_lambda_alias.preSignUp-trigger-alias.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 1
}

resource "aws_cloudwatch_log_group" "pollsqs-lambda-cloudwatch-group" {
  name              = "/aws/lambda/preSignUp"
  retention_in_days = var.logs-retention
  kms_key_id        = var.kms-key-arn
}
############################################################
# Configure RDS
############################################################
resource "aws_lambda_function" "setupDB" {
  s3_bucket     = local.codeBucket
  s3_key        = "${var.sawyer-version}/setup_db.zip"
  function_name = "setup_db"
  role          = aws_iam_role.lambda-role.arn
  handler       = "setup_db.lambda_handler"
  runtime       = "python3.7"
  description   = "A lambda function that sets up all the RDS permissions"
  timeout       = 30
  memory_size   = 128
  publish       = true

  environment {
    variables = {
      REGION              = var.region
      ENV                 = var.environment
      RDS_ENDPOINT        = aws_rds_cluster.postgresql-rds.endpoint
      RDS_MASTER_USR      = "postgres"
      RDS_DATABASE_NAME   = var.rds-db-name
      RDS_MASTER_USR_PWRD = var.rds-db-master-password
      TEMP_PWD_TWO        = random_password.password.result
    }
  }

  vpc_config {
    security_group_ids = var.security-group-ids
    subnet_ids         = var.private-subnet-ids
  }


}

resource "random_password" "password" {
  length           = 8
  special          = true
  override_special = "_%@"

  keepers = {
    # Generate a new id each time we run
    trigger = timestamp()
  }
}

resource "aws_lambda_alias" "setupDB-trigger-alias" {
  name             = upper(var.environment)
  description      = "Alias for the setupDB lambda"
  function_name    = aws_lambda_function.setupDB.arn
  function_version = aws_lambda_function.setupDB.version
  depends_on       = [aws_lambda_function.setupDB]
}

resource "aws_lambda_function_event_invoke_config" "setupDB-trigger-lambda-invoke-settings" {
  function_name                = aws_lambda_alias.setupDB-trigger-alias.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 1
}

resource "aws_cloudwatch_log_group" "setupDB-lambda-cloudwatch-group" {
  name              = "/aws/lambda/setup_db"
  retention_in_days = var.logs-retention
  kms_key_id        = var.kms-key-arn
}