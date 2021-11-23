resource "aws_lambda_function" "build-website" {
  s3_bucket     = local.codeBucket
  s3_key        = "${lower(var.sawyer-version)}/buildWebsite"
  function_name = "buildWebsite"
  role          = aws_iam_role.lambda-website-build-role.arn
  handler       = "main"
  kms_key_arn   = var.kms-key-arn

  source_code_hash = base64encode(lower(var.sawyer-version))
  runtime          = "go1.x"
  timeout          = 128
  memory_size      = var.website-build-lambda-memory-size
  publish          = true

  environment {
    variables = {
      REGION                = var.region
      USERPOOL_ID           = var.cognito-userpool-id
      WEBCLIENT_ID          = var.cognito-userpool-client-id
      API_URL               = "api.${var.domain}"
      SAWYER_VERSION        = var.sawyer-version
      ASSETS_SOURCE_BUCKET  = local.website-assets-source-bucket
      DEPLOY_WEBSITE_BUCKET = aws_s3_bucket.code-storage.id
    }
  }
}

resource "aws_lambda_alias" "build-website-alias" {
  name             = upper(var.environment)
  description      = "Alias for the build-website lambda"
  function_name    = aws_lambda_function.build-website.arn
  function_version = aws_lambda_function.build-website.version
  depends_on       = [aws_lambda_function.build-website]
}

resource "aws_lambda_function_event_invoke_config" "build-website-lambda-invoke-settings" {
  function_name                = aws_lambda_alias.build-website-alias.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 1
}

resource "aws_cloudwatch_log_group" "build-website-cloudwatch-group" {
  name              = "/aws/lambda/build_sawyer_website"
  retention_in_days = var.logs-retention
  kms_key_id        = var.kms-key-arn
}


resource "null_resource" "populate-rds" {
  count = var.profile == "" ? 1 : 0

  triggers = {
    id = var.sawyer-version
  }

  provisioner "local-exec" {
    command = <<EOT
      aws lambda invoke --function-name build_sawyer_website --region ${var.region} response.json
    EOT
  }
  depends_on = [aws_lambda_function.build-website, aws_cloudwatch_log_group.build-website-cloudwatch-group, aws_s3_bucket.code-storage]
}

resource "null_resource" "populate-rds-with-profile" {
  count = var.profile != "" ? 1 : 0

  triggers = {
    id = var.sawyer-version
  }

  provisioner "local-exec" {
    command = <<EOT
      aws lambda invoke --function-name build_sawyer_website --profile ${var.profile} --region ${var.region} response.json
    EOT
  }
  depends_on = [aws_lambda_function.build-website, aws_cloudwatch_log_group.build-website-cloudwatch-group, aws_s3_bucket.code-storage]
}