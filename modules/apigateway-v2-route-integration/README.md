# Terraform-aws-apigateway-v2-route-integration
Terraform module that integrates a route into API Gateway (HTTPS)

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api-id | The ID of the target API | `string` | n/a | yes |
| api-key-requirement | Setting that determines if an API key is required | `bool` | n/a | yes |
| authorization-type | The authorization type. Valid values are NONE \| JWT | `string` | n/a | yes |
| authorizer-id | The id of the Cognito authorizer | `string` | `null` | no |
| connection-type | The type of the network connection to the integration endpoint. Valid values: INTERNET, VPC\_LINK. Default is INTERNET. | `string` | `"INTERNET"` | no |
| description | The description of the integration. | `string` | n/a | yes |
| integration-method | The integration's HTTP method. Must be specified if integration\_type is not MOCK. | `string` | `"POST"` | no |
| integration-type | The integration type of an integration. Valid values: AWS, AWS\_PROXY, HTTP, HTTP\_PROXY, MOCK | `string` | `"AWS_PROXY"` | no |
| lambda-integration-uri | The URI of the Lambda function for a Lambda proxy integration, when integration\_type is AWS\_PROXY. For an HTTP integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service. | `string` | n/a | yes |
| passthrough-behavior | The pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the request\_templates attribute. Valid values: WHEN\_NO\_MATCH, WHEN\_NO\_TEMPLATES, NEVER. Default is WHEN\_NO\_MATCH. Supported only for WebSocket APIs. | `string` | n/a | yes |
| path-version | API Version path. Example: /v1/ | `string` | `null` | no |
| payload-format | The format of the payload sent to an integration. Valid values: 1.0, 2.0. Default is 1.0. | `string` | `"2.0"` | no |
| route-key | The route key, method/path. Example: GET /authors/{id} | `string` | n/a | yes |
| timeout | Custom timeout between 50 and 29,000 milliseconds. The default value is 29,000 milliseconds or 29 seconds. | `number` | `29000` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The integration identifier. |
| integration\_response\_selection\_expression | The [integration response selection expression](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-integration-response-selection-expressions) for the integration. |
| route-id | The route identifier. |

