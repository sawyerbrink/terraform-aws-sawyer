output "main-api-id" {
  value = aws_apigatewayv2_api.main-api.id
}

output "main-api-endpoint" {
  value = aws_apigatewayv2_api.main-api.api_endpoint
}

output "main-api-arn" {
  value = aws_apigatewayv2_api.main-api.arn
}

output "main-api-execution-arn" {
  value = aws_apigatewayv2_api.main-api.execution_arn
}

output "main-api-stage-id" {
  value = aws_apigatewayv2_stage.stage-1.id
}

output "main-api-stage-arn" {
  value = aws_apigatewayv2_stage.stage-1.arn
}

output "main-api-stage-invoke-url" {
  value = aws_apigatewayv2_stage.stage-1.invoke_url
}

output "main-api-authorizer-id" {
  value = aws_apigatewayv2_authorizer.route-authorizer.*.id
}