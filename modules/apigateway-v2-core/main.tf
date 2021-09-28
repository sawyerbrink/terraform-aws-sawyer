resource "aws_apigatewayv2_api" "main-api" {
  name                         = var.api-name
  protocol_type                = var.protocol-type
  description                  = var.api-description
  version                      = var.api-version
  disable_execute_api_endpoint = var.disable-default-endpoint

  cors_configuration {
    allow_credentials = var.cors-allow-credentials
    allow_headers     = var.cors-allow-headers
    allow_methods     = var.cors-allow-methods
    allow_origins     = var.cors-allow-origins
    expose_headers    = var.cors-expose-headers
    max_age           = var.cors-max-age
  }
}


resource "aws_apigatewayv2_stage" "stage-1" {
  api_id      = aws_apigatewayv2_api.main-api.id
  name        = var.stage-name
  auto_deploy = var.auto-deploy

  access_log_settings {
    destination_arn = var.destination-log-group-arn
    format          = var.access-log-format
  }

  default_route_settings {
    throttling_burst_limit = var.default-burst-limit //1000
    throttling_rate_limit  = var.default-rate-limit  //100
  }


  dynamic "route_settings" {
    for_each = var.route-keys

    content {
      route_key                = route_settings.value["key"]
      throttling_burst_limit   = route_settings.value["throttling_burst_limit"] //1000
      throttling_rate_limit    = route_settings.value["throttling_rate_limit"]  //100
      data_trace_enabled       = false
      detailed_metrics_enabled = false
      logging_level            = "OFF"
    }
  }
}


resource "aws_apigatewayv2_authorizer" "route-authorizer" {
  count = var.authorizer_type == "JWT" ? 1 : 0

  api_id           = aws_apigatewayv2_api.main-api.id
  authorizer_type  = var.authorizer_type
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = var.audience
    issuer   = "https://${var.auth-endpoint}"
  }
}