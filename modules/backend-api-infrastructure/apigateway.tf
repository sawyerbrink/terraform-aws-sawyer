#################################
# API Gateway - SawyerBrink
#################################
resource "aws_api_gateway_account" "api-logging" {
  cloudwatch_role_arn = aws_iam_role.APIGatwayCloudwatch-role.arn
}

module "apigateway-core" {
  source                   = "../apigateway-v2-core"
  api-description          = var.api-description
  api-name                 = var.api-name
  api-version              = var.api-version
  auto-deploy              = var.api-stage-auto-deploy
  stage-name               = var.api-stage-name
  protocol-type            = var.protocol-type
  disable-default-endpoint = var.disable-default-endpoint
  authorizer_type          = var.authorizer-type

  destination-log-group-arn = aws_cloudwatch_log_group.APIGateway-log-group.arn
  access-log-format         = var.access-log-format

  cors-allow-origins  = var.cors-allow-origins
  cors-allow-headers  = var.cors-allow-headers
  cors-allow-methods  = var.cors-allow-methods
  cors-expose-headers = var.cors-expose-headers

  audience      = [aws_cognito_user_pool_client.authorized-flow-client.id, aws_cognito_user_pool_client.implicit-flow-client.id]
  auth-endpoint = aws_cognito_user_pool.user-pool.endpoint


}
####################################
# API Gateway - Custom Domain Name
####################################
resource "aws_apigatewayv2_domain_name" "api-sawyerbrink" {
  domain_name = var.api-domain-name

  domain_name_configuration {
    certificate_arn = var.api-certificate-arn
    endpoint_type   = "REGIONAL"
    security_policy = var.security-policy
  }
}

resource "aws_apigatewayv2_api_mapping" "api-sawyerbrink-mapping" {
  api_id      = module.apigateway-core.main-api-id
  domain_name = aws_apigatewayv2_domain_name.api-sawyerbrink.id
  stage       = module.apigateway-core.main-api-stage-id

  depends_on = [module.apigateway-core.main-api-id, aws_apigatewayv2_domain_name.api-sawyerbrink]
}