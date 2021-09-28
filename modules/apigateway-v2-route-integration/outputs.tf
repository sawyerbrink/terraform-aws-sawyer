output "route-id" {
  description = "The route identifier."
  value       = aws_apigatewayv2_route.route.id
}

output "id" {
  description = "The integration identifier."
  value       = aws_apigatewayv2_integration.lambda-integration.id
}

output "integration_response_selection_expression" {
  description = "The [integration response selection expression](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-integration-response-selection-expressions) for the integration."
  value       = aws_apigatewayv2_integration.lambda-integration.integration_response_selection_expression
}