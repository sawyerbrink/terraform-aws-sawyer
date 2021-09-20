resource "aws_apigatewayv2_route" "route" {
  api_id             = var.api-id
  route_key          = var.route-key
  api_key_required   = var.api-key-requirement
  target             = "integrations/${aws_apigatewayv2_integration.lambda-integration.id}"
  authorizer_id      = var.authorizer-id
  authorization_type = var.authorization-type
}

resource "aws_apigatewayv2_integration" "lambda-integration" {
  api_id                 = var.api-id
  integration_type       = var.integration-type
  connection_type        = var.connection-type
  description            = var.description
  integration_method     = var.integration-method
  integration_uri        = var.lambda-integration-uri
  passthrough_behavior   = var.passthrough-behavior
  payload_format_version = var.payload-format
  timeout_milliseconds   = var.timeout
}