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