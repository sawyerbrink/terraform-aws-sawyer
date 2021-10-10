resource "aws_lambda_function" "build-website" {
  image_uri = "public.ecr.aws/y9t7n6s4/sawyerbrink-lambda-images:${lower(var.sawyer-version)}"

  function_name = "build_sawyer_website"
  role          = aws_iam_role.lambda-website-build-role.arn
  handler       = "app.handler"
  kms_key_arn   = var.kms-key-arn

  source_code_hash = base64encode(lower(var.sawyer-version))
  runtime          = "nodejs14.x"
  timeout          = 500
  memory_size      = var.website-build-lambda-memory-size
  publish          = true

  environment {
    variables = {
      REACT_APP_REGION_NAME           = var.region
      REACT_APP_USERPOOL_ID           = var.cognito-userpool-id
      REACT_APP_USERPOOL_WEBCLIENT_ID = var.cognito-userpool-client-id
      REACT_APP_API_URL               = "api.${var.domain}"
      DEPLOY_WEBSITE_BUCKET           = aws_s3_bucket.code-storage.id
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