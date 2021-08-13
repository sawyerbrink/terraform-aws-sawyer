## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend-api-infrastructure"></a> [backend-api-infrastructure](#module\_backend-api-infrastructure) | ./modules/backend-api-infrastructure | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backendinfra-access-log-format"></a> [backendinfra-access-log-format](#input\_backendinfra-access-log-format) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-api-description"></a> [backendinfra-api-description](#input\_backendinfra-api-description) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-api-domain-name"></a> [backendinfra-api-domain-name](#input\_backendinfra-api-domain-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-api-name"></a> [backendinfra-api-name](#input\_backendinfra-api-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-api-stage-auto-deploy"></a> [backendinfra-api-stage-auto-deploy](#input\_backendinfra-api-stage-auto-deploy) | n/a | `bool` | n/a | yes |
| <a name="input_backendinfra-api-stage-name"></a> [backendinfra-api-stage-name](#input\_backendinfra-api-stage-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-api-version"></a> [backendinfra-api-version](#input\_backendinfra-api-version) | The version of the API | `string` | n/a | yes |
| <a name="input_backendinfra-auth-domain"></a> [backendinfra-auth-domain](#input\_backendinfra-auth-domain) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-batch-cpu"></a> [backendinfra-batch-cpu](#input\_backendinfra-batch-cpu) | The number of CPUs to allocated for the batch job | `number` | n/a | yes |
| <a name="input_backendinfra-batch-memory"></a> [backendinfra-batch-memory](#input\_backendinfra-batch-memory) | The memory size to allocated for the batch job | `number` | n/a | yes |
| <a name="input_backendinfra-cors-allow-headers"></a> [backendinfra-cors-allow-headers](#input\_backendinfra-cors-allow-headers) | n/a | `list(any)` | n/a | yes |
| <a name="input_backendinfra-cors-allow-methods"></a> [backendinfra-cors-allow-methods](#input\_backendinfra-cors-allow-methods) | n/a | `list(any)` | n/a | yes |
| <a name="input_backendinfra-cors-allow-origins"></a> [backendinfra-cors-allow-origins](#input\_backendinfra-cors-allow-origins) | n/a | `list(any)` | n/a | yes |
| <a name="input_backendinfra-cors-expose-headers"></a> [backendinfra-cors-expose-headers](#input\_backendinfra-cors-expose-headers) | n/a | `list(any)` | n/a | yes |
| <a name="input_backendinfra-domain-name"></a> [backendinfra-domain-name](#input\_backendinfra-domain-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-environment"></a> [backendinfra-environment](#input\_backendinfra-environment) | The environment for the infrastrcutrue (dev, test, prod) | `string` | n/a | yes |
| <a name="input_backendinfra-fargate-version"></a> [backendinfra-fargate-version](#input\_backendinfra-fargate-version) | The AWS Fargate version to use for batch jobs. | `string` | n/a | yes |
| <a name="input_backendinfra-lambda-sqs-index-document-concurrency-limit"></a> [backendinfra-lambda-sqs-index-document-concurrency-limit](#input\_backendinfra-lambda-sqs-index-document-concurrency-limit) | Amount of capacity to allocate. Must be greater than or equal to 1 | `number` | n/a | yes |
| <a name="input_backendinfra-lambda-sqs-logging-concurrency-limit"></a> [backendinfra-lambda-sqs-logging-concurrency-limit](#input\_backendinfra-lambda-sqs-logging-concurrency-limit) | Amount of capacity to allocate. Must be greater than or equal to 1 | `number` | n/a | yes |
| <a name="input_backendinfra-newslitapi-parameter-name"></a> [backendinfra-newslitapi-parameter-name](#input\_backendinfra-newslitapi-parameter-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-passthrough-behavior"></a> [backendinfra-passthrough-behavior](#input\_backendinfra-passthrough-behavior) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-protocol-type"></a> [backendinfra-protocol-type](#input\_backendinfra-protocol-type) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-rds-db-name"></a> [backendinfra-rds-db-name](#input\_backendinfra-rds-db-name) | The DB name | `string` | n/a | yes |
| <a name="input_backendinfra-rds-db-port"></a> [backendinfra-rds-db-port](#input\_backendinfra-rds-db-port) | The RDS port that accepts network traffic. | `number` | n/a | yes |
| <a name="input_backendinfra-rds-postgres-engine"></a> [backendinfra-rds-postgres-engine](#input\_backendinfra-rds-postgres-engine) | The RDS postgres engine to utilize | `string` | n/a | yes |
| <a name="input_backendinfra-rds-postgres-engine-version"></a> [backendinfra-rds-postgres-engine-version](#input\_backendinfra-rds-postgres-engine-version) | The RDS postgres engine version to use. | `string` | n/a | yes |
| <a name="input_backendinfra-rds-read-role"></a> [backendinfra-rds-read-role](#input\_backendinfra-rds-read-role) | The read role for the RDS postgres database | `string` | n/a | yes |
| <a name="input_backendinfra-rds-write-role"></a> [backendinfra-rds-write-role](#input\_backendinfra-rds-write-role) | The write role for the RDS postgres database | `string` | n/a | yes |
| <a name="input_backendinfra-region"></a> [backendinfra-region](#input\_backendinfra-region) | The AWS region to use | `string` | n/a | yes |
| <a name="input_backendinfra-risk-sensing-image-version"></a> [backendinfra-risk-sensing-image-version](#input\_backendinfra-risk-sensing-image-version) | The version for the risk-sensing image to use | `string` | n/a | yes |
| <a name="input_backendinfra-route-timeout"></a> [backendinfra-route-timeout](#input\_backendinfra-route-timeout) | n/a | `number` | n/a | yes |
| <a name="input_backendinfra-sawyerbrink-ns"></a> [backendinfra-sawyerbrink-ns](#input\_backendinfra-sawyerbrink-ns) | n/a | `list(any)` | n/a | yes |
| <a name="input_backendinfra-sawyerbrink-soa"></a> [backendinfra-sawyerbrink-soa](#input\_backendinfra-sawyerbrink-soa) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-security-policy"></a> [backendinfra-security-policy](#input\_backendinfra-security-policy) | The TLS policy to apply to the API Gateway domain | `string` | n/a | yes |
| <a name="input_backendinfra-support-sns-topic"></a> [backendinfra-support-sns-topic](#input\_backendinfra-support-sns-topic) | The SNS topic to leverage for support purposes | `string` | n/a | yes |
| <a name="input_backendinfra-tags"></a> [backendinfra-tags](#input\_backendinfra-tags) | A map of commonly used tags | `map(any)` | n/a | yes |
| <a name="input_backendinfra-tracing-mode"></a> [backendinfra-tracing-mode](#input\_backendinfra-tracing-mode) | n/a | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | The AWS configuration profile to use | `any` | n/a | yes |
| <a name="input_sawyer-version"></a> [sawyer-version](#input\_sawyer-version) | The version of sawyer to use | `string` | `"latest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backendinfra-ApiGateway-domain-api_mapping_selection_expression"></a> [backendinfra-ApiGateway-domain-api\_mapping\_selection\_expression](#output\_backendinfra-ApiGateway-domain-api\_mapping\_selection\_expression) | n/a |
| <a name="output_backendinfra-ApiGateway-domain-arn"></a> [backendinfra-ApiGateway-domain-arn](#output\_backendinfra-ApiGateway-domain-arn) | n/a |
| <a name="output_backendinfra-ApiGateway-domain-id"></a> [backendinfra-ApiGateway-domain-id](#output\_backendinfra-ApiGateway-domain-id) | n/a |
| <a name="output_backendinfra-api-gateway-authorizer-id"></a> [backendinfra-api-gateway-authorizer-id](#output\_backendinfra-api-gateway-authorizer-id) | n/a |
| <a name="output_backendinfra-api-target-domain"></a> [backendinfra-api-target-domain](#output\_backendinfra-api-target-domain) | n/a |
| <a name="output_backendinfra-apigateway-delete-role-arn"></a> [backendinfra-apigateway-delete-role-arn](#output\_backendinfra-apigateway-delete-role-arn) | n/a |
| <a name="output_backendinfra-apigateway-presigned-role-arn"></a> [backendinfra-apigateway-presigned-role-arn](#output\_backendinfra-apigateway-presigned-role-arn) | n/a |
| <a name="output_backendinfra-apigateway-s3-role-arn"></a> [backendinfra-apigateway-s3-role-arn](#output\_backendinfra-apigateway-s3-role-arn) | n/a |
| <a name="output_backendinfra-audit-sqs-arn"></a> [backendinfra-audit-sqs-arn](#output\_backendinfra-audit-sqs-arn) | n/a |
| <a name="output_backendinfra-audit-sqs-url"></a> [backendinfra-audit-sqs-url](#output\_backendinfra-audit-sqs-url) | n/a |
| <a name="output_backendinfra-aurora-db-arn"></a> [backendinfra-aurora-db-arn](#output\_backendinfra-aurora-db-arn) | n/a |
| <a name="output_backendinfra-aurora-db-cluster-resource-id"></a> [backendinfra-aurora-db-cluster-resource-id](#output\_backendinfra-aurora-db-cluster-resource-id) | n/a |
| <a name="output_backendinfra-aurora-db-custom-reader-endpoint"></a> [backendinfra-aurora-db-custom-reader-endpoint](#output\_backendinfra-aurora-db-custom-reader-endpoint) | n/a |
| <a name="output_backendinfra-aurora-db-custom-writer-endpoint"></a> [backendinfra-aurora-db-custom-writer-endpoint](#output\_backendinfra-aurora-db-custom-writer-endpoint) | n/a |
| <a name="output_backendinfra-aurora-db-endpoint"></a> [backendinfra-aurora-db-endpoint](#output\_backendinfra-aurora-db-endpoint) | n/a |
| <a name="output_backendinfra-aurora-db-id"></a> [backendinfra-aurora-db-id](#output\_backendinfra-aurora-db-id) | n/a |
| <a name="output_backendinfra-aurora-db-identifier"></a> [backendinfra-aurora-db-identifier](#output\_backendinfra-aurora-db-identifier) | n/a |
| <a name="output_backendinfra-aurora-db-reader-endpoint"></a> [backendinfra-aurora-db-reader-endpoint](#output\_backendinfra-aurora-db-reader-endpoint) | n/a |
| <a name="output_backendinfra-aurora-db-reader-r53-hosted-zone"></a> [backendinfra-aurora-db-reader-r53-hosted-zone](#output\_backendinfra-aurora-db-reader-r53-hosted-zone) | n/a |
| <a name="output_backendinfra-authorized-flow-client-id"></a> [backendinfra-authorized-flow-client-id](#output\_backendinfra-authorized-flow-client-id) | n/a |
| <a name="output_backendinfra-batch-compute-environment-arn"></a> [backendinfra-batch-compute-environment-arn](#output\_backendinfra-batch-compute-environment-arn) | n/a |
| <a name="output_backendinfra-batch-compute-environment-ecs-cluster-arn"></a> [backendinfra-batch-compute-environment-ecs-cluster-arn](#output\_backendinfra-batch-compute-environment-ecs-cluster-arn) | n/a |
| <a name="output_backendinfra-batch-compute-environment-job-definition-arn"></a> [backendinfra-batch-compute-environment-job-definition-arn](#output\_backendinfra-batch-compute-environment-job-definition-arn) | n/a |
| <a name="output_backendinfra-batch-compute-queue-arn"></a> [backendinfra-batch-compute-queue-arn](#output\_backendinfra-batch-compute-queue-arn) | n/a |
| <a name="output_backendinfra-cloudwatch-cron-role"></a> [backendinfra-cloudwatch-cron-role](#output\_backendinfra-cloudwatch-cron-role) | n/a |
| <a name="output_backendinfra-cluster-identifier"></a> [backendinfra-cluster-identifier](#output\_backendinfra-cluster-identifier) | n/a |
| <a name="output_backendinfra-customer-documents-bucket-id"></a> [backendinfra-customer-documents-bucket-id](#output\_backendinfra-customer-documents-bucket-id) | n/a |
| <a name="output_backendinfra-customer-sqs-arn"></a> [backendinfra-customer-sqs-arn](#output\_backendinfra-customer-sqs-arn) | n/a |
| <a name="output_backendinfra-customer-sqs-url"></a> [backendinfra-customer-sqs-url](#output\_backendinfra-customer-sqs-url) | n/a |
| <a name="output_backendinfra-implicit-client-id"></a> [backendinfra-implicit-client-id](#output\_backendinfra-implicit-client-id) | n/a |
| <a name="output_backendinfra-lambda-batch-trigger-role-arn"></a> [backendinfra-lambda-batch-trigger-role-arn](#output\_backendinfra-lambda-batch-trigger-role-arn) | n/a |
| <a name="output_backendinfra-lambda-index-documents-role-arn"></a> [backendinfra-lambda-index-documents-role-arn](#output\_backendinfra-lambda-index-documents-role-arn) | n/a |
| <a name="output_backendinfra-lambda-rds-role-arn"></a> [backendinfra-lambda-rds-role-arn](#output\_backendinfra-lambda-rds-role-arn) | n/a |
| <a name="output_backendinfra-lambda-s3-role-arn"></a> [backendinfra-lambda-s3-role-arn](#output\_backendinfra-lambda-s3-role-arn) | n/a |
| <a name="output_backendinfra-lambda-sqs-role-arn"></a> [backendinfra-lambda-sqs-role-arn](#output\_backendinfra-lambda-sqs-role-arn) | n/a |
| <a name="output_backendinfra-logging-bucket-id"></a> [backendinfra-logging-bucket-id](#output\_backendinfra-logging-bucket-id) | n/a |
| <a name="output_backendinfra-main-api-arn"></a> [backendinfra-main-api-arn](#output\_backendinfra-main-api-arn) | n/a |
| <a name="output_backendinfra-main-api-endpoint"></a> [backendinfra-main-api-endpoint](#output\_backendinfra-main-api-endpoint) | n/a |
| <a name="output_backendinfra-main-api-id"></a> [backendinfra-main-api-id](#output\_backendinfra-main-api-id) | n/a |
| <a name="output_backendinfra-main-api-mapping"></a> [backendinfra-main-api-mapping](#output\_backendinfra-main-api-mapping) | n/a |
| <a name="output_backendinfra-main-api-prod-execution-arn"></a> [backendinfra-main-api-prod-execution-arn](#output\_backendinfra-main-api-prod-execution-arn) | n/a |
| <a name="output_backendinfra-main-api-prod-stage-arn"></a> [backendinfra-main-api-prod-stage-arn](#output\_backendinfra-main-api-prod-stage-arn) | n/a |
| <a name="output_backendinfra-main-api-prod-stage-id"></a> [backendinfra-main-api-prod-stage-id](#output\_backendinfra-main-api-prod-stage-id) | n/a |
| <a name="output_backendinfra-main-api-prod-stage-invoke-url"></a> [backendinfra-main-api-prod-stage-invoke-url](#output\_backendinfra-main-api-prod-stage-invoke-url) | n/a |
| <a name="output_backendinfra-main-lambda-role-arn"></a> [backendinfra-main-lambda-role-arn](#output\_backendinfra-main-lambda-role-arn) | n/a |
| <a name="output_backendinfra-organization-table-arn"></a> [backendinfra-organization-table-arn](#output\_backendinfra-organization-table-arn) | n/a |
| <a name="output_backendinfra-organization-table-id"></a> [backendinfra-organization-table-id](#output\_backendinfra-organization-table-id) | n/a |
| <a name="output_backendinfra-organization-table-stream-arn"></a> [backendinfra-organization-table-stream-arn](#output\_backendinfra-organization-table-stream-arn) | n/a |
| <a name="output_backendinfra-user-pool-arn"></a> [backendinfra-user-pool-arn](#output\_backendinfra-user-pool-arn) | n/a |
| <a name="output_backendinfra-user-pool-endpoint"></a> [backendinfra-user-pool-endpoint](#output\_backendinfra-user-pool-endpoint) | n/a |
| <a name="output_backendinfra-user-pool-id"></a> [backendinfra-user-pool-id](#output\_backendinfra-user-pool-id) | n/a |
