## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_api.main-api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_authorizer.route-authorizer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_authorizer) | resource |
| [aws_apigatewayv2_stage.stage-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access-log-format"></a> [access-log-format](#input\_access-log-format) | A single line format of the access logs of data, as specified by selected $context variables. | `string` | `"{ \"requestId\":\"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"requestTime\":\"$context.requestTime\", \"httpMethod\":\"$context.httpMethod\",\"routeKey\":\"$context.routeKey\", \"status\":\"$context.status\",\"protocol\":\"$context.protocol\", \"responseLength\":\"$context.responseLength\" }"` | no |
| <a name="input_api-description"></a> [api-description](#input\_api-description) | A decription of the API | `string` | n/a | yes |
| <a name="input_api-name"></a> [api-name](#input\_api-name) | The name of the API | `string` | n/a | yes |
| <a name="input_api-version"></a> [api-version](#input\_api-version) | The version of the API | `string` | n/a | yes |
| <a name="input_audience"></a> [audience](#input\_audience) | A list of the intended recipients of the JWT. A valid JWT must provide an aud that matches at least one entry in this list. | `list(any)` | `[]` | no |
| <a name="input_auth-endpoint"></a> [auth-endpoint](#input\_auth-endpoint) | The base domain of the identity provider that issues JSON Web Tokens | `string` | `""` | no |
| <a name="input_authorizer_type"></a> [authorizer\_type](#input\_authorizer\_type) | The authorization type to use | `string` | n/a | yes |
| <a name="input_auto-deploy"></a> [auto-deploy](#input\_auto-deploy) | The setting for auto-deploy within the created stage. Default value is false | `bool` | `false` | no |
| <a name="input_cors-allow-credentials"></a> [cors-allow-credentials](#input\_cors-allow-credentials) | (Optional) Whether credentials are included in the CORS request | `bool` | `false` | no |
| <a name="input_cors-allow-headers"></a> [cors-allow-headers](#input\_cors-allow-headers) | (Optional) The set of allowed HTTP headers. | `list(any)` | `[]` | no |
| <a name="input_cors-allow-methods"></a> [cors-allow-methods](#input\_cors-allow-methods) | (Optional) The set of allowed HTTP methods. | `list(any)` | `[]` | no |
| <a name="input_cors-allow-origins"></a> [cors-allow-origins](#input\_cors-allow-origins) | (Optional) The set of allowed origins | `list(any)` | `[]` | no |
| <a name="input_cors-expose-headers"></a> [cors-expose-headers](#input\_cors-expose-headers) | (Optional) The set of exposed HTTP headers | `list(any)` | `[]` | no |
| <a name="input_cors-max-age"></a> [cors-max-age](#input\_cors-max-age) | (Optional) The number of seconds that the browser should cache preflight request results. | `number` | `300` | no |
| <a name="input_default-burst-limit"></a> [default-burst-limit](#input\_default-burst-limit) | The throttling burst limit for the default route | `number` | `1000` | no |
| <a name="input_default-rate-limit"></a> [default-rate-limit](#input\_default-rate-limit) | The throttling rate limit for the default route | `number` | `100` | no |
| <a name="input_destination-log-group-arn"></a> [destination-log-group-arn](#input\_destination-log-group-arn) | The ARN of the CloudWatch Logs log group to receive access logs. Any trailing :* is trimmed from the ARN | `string` | n/a | yes |
| <a name="input_disable-default-endpoint"></a> [disable-default-endpoint](#input\_disable-default-endpoint) | Enable/Disable the deafault API Gateway exposed by API Gateway | `bool` | `false` | no |
| <a name="input_protocol-type"></a> [protocol-type](#input\_protocol-type) | The protocol type for the API Gateway. Valid values are: HTTP \| WEBSOCKET | `string` | n/a | yes |
| <a name="input_route-keys"></a> [route-keys](#input\_route-keys) | A list of route keys to enable logging | `list(any)` | `[]` | no |
| <a name="input_stage-name"></a> [stage-name](#input\_stage-name) | The name of the stage defined for the API | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_main-api-arn"></a> [main-api-arn](#output\_main-api-arn) | n/a |
| <a name="output_main-api-authorizer-id"></a> [main-api-authorizer-id](#output\_main-api-authorizer-id) | n/a |
| <a name="output_main-api-endpoint"></a> [main-api-endpoint](#output\_main-api-endpoint) | n/a |
| <a name="output_main-api-execution-arn"></a> [main-api-execution-arn](#output\_main-api-execution-arn) | n/a |
| <a name="output_main-api-id"></a> [main-api-id](#output\_main-api-id) | n/a |
| <a name="output_main-api-stage-arn"></a> [main-api-stage-arn](#output\_main-api-stage-arn) | n/a |
| <a name="output_main-api-stage-id"></a> [main-api-stage-id](#output\_main-api-stage-id) | n/a |
| <a name="output_main-api-stage-invoke-url"></a> [main-api-stage-invoke-url](#output\_main-api-stage-invoke-url) | n/a |
