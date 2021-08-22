## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access-log-format | A single line format of the access logs of data, as specified by selected $context variables. | `string` | `"{ \"requestId\":\"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"requestTime\":\"$context.requestTime\", \"httpMethod\":\"$context.httpMethod\",\"routeKey\":\"$context.routeKey\", \"status\":\"$context.status\",\"protocol\":\"$context.protocol\", \"responseLength\":\"$context.responseLength\" }"` | no |
| api-description | A decription of the API | `string` | n/a | yes |
| api-name | The name of the API | `string` | n/a | yes |
| api-version | The version of the API | `string` | n/a | yes |
| audience | A list of the intended recipients of the JWT. A valid JWT must provide an aud that matches at least one entry in this list. | `list(any)` | `[]` | no |
| auth-endpoint | The base domain of the identity provider that issues JSON Web Tokens | `string` | `""` | no |
| authorizer\_type | The authorization type to use | `string` | n/a | yes |
| auto-deploy | The setting for auto-deploy within the created stage. Default value is false | `bool` | `false` | no |
| cors-allow-credentials | (Optional) Whether credentials are included in the CORS request | `bool` | `false` | no |
| cors-allow-headers | (Optional) The set of allowed HTTP headers. | `list(any)` | `[]` | no |
| cors-allow-methods | (Optional) The set of allowed HTTP methods. | `list(any)` | `[]` | no |
| cors-allow-origins | (Optional) The set of allowed origins | `list(any)` | `[]` | no |
| cors-expose-headers | (Optional) The set of exposed HTTP headers | `list(any)` | `[]` | no |
| cors-max-age | (Optional) The number of seconds that the browser should cache preflight request results. | `number` | `300` | no |
| default-burst-limit | The throttling burst limit for the default route | `number` | `1000` | no |
| default-rate-limit | The throttling rate limit for the default route | `number` | `100` | no |
| destination-log-group-arn | The ARN of the CloudWatch Logs log group to receive access logs. Any trailing :\* is trimmed from the ARN | `string` | n/a | yes |
| disable-default-endpoint | Enable/Disable the deafault API Gateway exposed by API Gateway | `bool` | `false` | no |
| protocol-type | The protocol type for the API Gateway. Valid values are: HTTP \| WEBSOCKET | `string` | n/a | yes |
| route-keys | A list of route keys to enable logging | `list(any)` | `[]` | no |
| stage-name | The name of the stage defined for the API | `string` | n/a | yes |
| tags | A map containing tags to provide the API Gateway resources | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| main-api-arn | n/a |
| main-api-endpoint | n/a |
| main-api-execution-arn | n/a |
| main-api-id | n/a |
| main-api-stage-arn | n/a |
| main-api-stage-id | n/a |
| main-api-stage-invoke-url | n/a |

