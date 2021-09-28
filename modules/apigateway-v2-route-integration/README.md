## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_integration.lambda-integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api-id"></a> [api-id](#input\_api-id) | The ID of the target API | `string` | n/a | yes |
| <a name="input_api-key-requirement"></a> [api-key-requirement](#input\_api-key-requirement) | Setting that determines if an API key is required | `bool` | n/a | yes |
| <a name="input_authorization-type"></a> [authorization-type](#input\_authorization-type) | The authorization type. Valid values are NONE \| JWT | `string` | n/a | yes |
| <a name="input_authorizer-id"></a> [authorizer-id](#input\_authorizer-id) | The id of the Cognito authorizer | `string` | `null` | no |
| <a name="input_connection-type"></a> [connection-type](#input\_connection-type) | The type of the network connection to the integration endpoint. Valid values: INTERNET, VPC\_LINK. Default is INTERNET. | `string` | `"INTERNET"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the integration. | `string` | n/a | yes |
| <a name="input_integration-method"></a> [integration-method](#input\_integration-method) | The integration's HTTP method. Must be specified if integration\_type is not MOCK. | `string` | `"POST"` | no |
| <a name="input_integration-type"></a> [integration-type](#input\_integration-type) | The integration type of an integration. Valid values: AWS, AWS\_PROXY, HTTP, HTTP\_PROXY, MOCK | `string` | `"AWS_PROXY"` | no |
| <a name="input_lambda-integration-uri"></a> [lambda-integration-uri](#input\_lambda-integration-uri) | The URI of the Lambda function for a Lambda proxy integration, when integration\_type is AWS\_PROXY. For an HTTP integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service. | `string` | n/a | yes |
| <a name="input_passthrough-behavior"></a> [passthrough-behavior](#input\_passthrough-behavior) | The pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the request\_templates attribute. Valid values: WHEN\_NO\_MATCH, WHEN\_NO\_TEMPLATES, NEVER. Default is WHEN\_NO\_MATCH. Supported only for WebSocket APIs. | `string` | n/a | yes |
| <a name="input_path-version"></a> [path-version](#input\_path-version) | API Version path. Example: /v1/ | `string` | `null` | no |
| <a name="input_payload-format"></a> [payload-format](#input\_payload-format) | The format of the payload sent to an integration. Valid values: 1.0, 2.0. Default is 1.0. | `string` | `"2.0"` | no |
| <a name="input_route-key"></a> [route-key](#input\_route-key) | The route key, method/path. Example: GET /authors/{id} | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Custom timeout between 50 and 29,000 milliseconds. The default value is 29,000 milliseconds or 29 seconds. | `number` | `29000` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The integration identifier. |
| <a name="output_integration_response_selection_expression"></a> [integration\_response\_selection\_expression](#output\_integration\_response\_selection\_expression) | The [integration response selection expression](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-integration-response-selection-expressions) for the integration. |
| <a name="output_route-id"></a> [route-id](#output\_route-id) | The route identifier. |
