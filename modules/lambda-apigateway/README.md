# terraform-aws-lambda-apigateway## Requirements

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
| alias | The name of alias to create for the Lambda function | `string` | n/a | yes |
| alias-description | A description of the Lambda alias | `string` | `""` | no |
| api-source-arn | When the principal is an AWS service, the ARN of the specific resource within that service to grant permission to. | `string` | n/a | yes |
| code-signing-config-arn | Amazon Resource Name (ARN) for a Code Signing Configuration. | `string` | `""` | no |
| description | Description of what your Lambda Function does. | `string` | n/a | yes |
| dlq-target-arn | The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted. | `string` | `""` | no |
| environment | A map containing environment variable for the function to leverage | `map(any)` | `{}` | no |
| function-name | The name of the Lambda function | `string` | n/a | yes |
| function-role-arn | IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details. | `string` | n/a | yes |
| handler | The function entrypoint in your code. | `string` | n/a | yes |
| kms-key-arn-cloudwatch | Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt the cloudwatch log | `string` | `""` | no |
| kms-key-arn-lambda | Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables | `string` | `""` | no |
| layers | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function | `list(any)` | `[]` | no |
| logs-retention | The number of days to retain the Cloudwatch logs in the log group | `number` | `3` | no |
| memory-size | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128 | `number` | `128` | no |
| publish | Whether to publish creation/change as new Lambda Function Version. Defaults to false. | `bool` | n/a | yes |
| reserved-concurrent-executions | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. | `number` | `-1` | no |
| runtime | Valid Values: nodejs10.x \| nodejs12.x \| java8 \| java11 \| python2.7 \| python3.6 \| python3.7 \| python3.8 \| dotnetcore2.1 \| dotnetcore3.1 \| go1.x \| ruby2.5 \| ruby2.7 \| provided | `string` | n/a | yes |
| s3-bucket-name | The bucket name where the Lambda code is stored. | `string` | n/a | yes |
| s3-key | The key name in s3 for the lambda code (file name). | `string` | n/a | yes |
| security-groups-ids | A list of security group IDs associated with the Lambda function. | `list(any)` | `[]` | no |
| source-code-hash | Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3\_key | `string` | `""` | no |
| subnet-ids | A list of subnet IDs associated with the Lambda function | `list(any)` | `[]` | no |
| tags | A map containing tag keys and values to pass to the function. | `map(any)` | `{}` | no |
| timeout | The default timeout value for this lambda | `number` | `15` | no |
| tracing-mode | Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with "sampled=1". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | `string` | `"PassThrough"` | no |

## Outputs

| Name | Description |
|------|-------------|
| alias-arn | The Amazon Resource Name (ARN) identifying your Lambda function alias. |
| alias\_invoke\_arn | The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri |
| arn | The Amazon Resource Name (ARN) identifying your Lambda Function. |
| invoke\_arn | The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri |
| kms\_key\_arn\_lambda | The ARN for the KMS encryption key. |
| last\_modified | n/a |
| qualified-arn | The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true) |
| source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_\* parameters. |
| source\_code\_size | The size in bytes of the function .zip file. |
| version | Latest published version of your Lambda Function. |

