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
| [aws_cloudwatch_log_group.lambda-cloudwatch-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lambda_alias.lambda-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.invoke-settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_permission.lambda-permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | The name of alias to create for the Lambda function | `string` | n/a | yes |
| <a name="input_alias-description"></a> [alias-description](#input\_alias-description) | A description of the Lambda alias | `string` | `""` | no |
| <a name="input_api-source-arn"></a> [api-source-arn](#input\_api-source-arn) | When the principal is an AWS service, the ARN of the specific resource within that service to grant permission to. | `string` | n/a | yes |
| <a name="input_code-signing-config-arn"></a> [code-signing-config-arn](#input\_code-signing-config-arn) | Amazon Resource Name (ARN) for a Code Signing Configuration. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | n/a | yes |
| <a name="input_dlq-target-arn"></a> [dlq-target-arn](#input\_dlq-target-arn) | The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | A map containing environment variable for the function to leverage | `map(any)` | `{}` | no |
| <a name="input_function-name"></a> [function-name](#input\_function-name) | The name of the Lambda function | `string` | n/a | yes |
| <a name="input_function-role-arn"></a> [function-role-arn](#input\_function-role-arn) | IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details. | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | The function entrypoint in your code. | `string` | n/a | yes |
| <a name="input_kms-key-arn-cloudwatch"></a> [kms-key-arn-cloudwatch](#input\_kms-key-arn-cloudwatch) | Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt the cloudwatch log | `string` | `""` | no |
| <a name="input_kms-key-arn-lambda"></a> [kms-key-arn-lambda](#input\_kms-key-arn-lambda) | Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables | `string` | `""` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function | `list(any)` | `[]` | no |
| <a name="input_logs-retention"></a> [logs-retention](#input\_logs-retention) | The number of days to retain the Cloudwatch logs in the log group | `number` | `3` | no |
| <a name="input_memory-size"></a> [memory-size](#input\_memory-size) | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128 | `number` | `128` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new Lambda Function Version. Defaults to false. | `bool` | n/a | yes |
| <a name="input_reserved-concurrent-executions"></a> [reserved-concurrent-executions](#input\_reserved-concurrent-executions) | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. | `number` | `-1` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Valid Values: nodejs10.x \| nodejs12.x \| java8 \| java11 \| python2.7 \| python3.6 \| python3.7 \| python3.8 \| dotnetcore2.1 \| dotnetcore3.1 \| go1.x \| ruby2.5 \| ruby2.7 \| provided | `string` | n/a | yes |
| <a name="input_s3-bucket-name"></a> [s3-bucket-name](#input\_s3-bucket-name) | The bucket name where the Lambda code is stored. | `string` | n/a | yes |
| <a name="input_s3-key"></a> [s3-key](#input\_s3-key) | The key name in s3 for the lambda code (file name). | `string` | n/a | yes |
| <a name="input_security-groups-ids"></a> [security-groups-ids](#input\_security-groups-ids) | A list of security group IDs associated with the Lambda function. | `list(any)` | `[]` | no |
| <a name="input_source-code-hash"></a> [source-code-hash](#input\_source-code-hash) | Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3\_key | `string` | `""` | no |
| <a name="input_subnet-ids"></a> [subnet-ids](#input\_subnet-ids) | A list of subnet IDs associated with the Lambda function | `list(any)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map containing tag keys and values to pass to the function. | `map(any)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The default timeout value for this lambda | `number` | `15` | no |
| <a name="input_tracing-mode"></a> [tracing-mode](#input\_tracing-mode) | Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with "sampled=1". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | `string` | `"PassThrough"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias-arn"></a> [alias-arn](#output\_alias-arn) | The Amazon Resource Name (ARN) identifying your Lambda function alias. |
| <a name="output_alias_invoke_arn"></a> [alias\_invoke\_arn](#output\_alias\_invoke\_arn) | The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri |
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) identifying your Lambda Function. |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri |
| <a name="output_kms_key_arn_lambda"></a> [kms\_key\_arn\_lambda](#output\_kms\_key\_arn\_lambda) | The ARN for the KMS encryption key. |
| <a name="output_last_modified"></a> [last\_modified](#output\_last\_modified) | n/a |
| <a name="output_qualified-arn"></a> [qualified-arn](#output\_qualified-arn) | The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true) |
| <a name="output_source_code_hash"></a> [source\_code\_hash](#output\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_source_code_size"></a> [source\_code\_size](#output\_source\_code\_size) | The size in bytes of the function .zip file. |
| <a name="output_version"></a> [version](#output\_version) | Latest published version of your Lambda Function. |
