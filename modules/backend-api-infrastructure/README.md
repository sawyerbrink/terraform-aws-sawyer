## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apigateway-core"></a> [apigateway-core](#module\_apigateway-core) | ../apigateway-v2-core | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_account.api-logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_apigatewayv2_api_mapping.api-sawyerbrink-mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_domain_name.api-sawyerbrink](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_batch_compute_environment.batch-compute-environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_compute_environment) | resource |
| [aws_batch_job_definition.batch-compute-job-definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_definition) | resource |
| [aws_batch_job_queue.batch-compute-queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_queue) | resource |
| [aws_cloudwatch_log_group.APIGateway-log-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.aws_batch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.pollsqs-lambda-cloudwatch-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.populate_rds-lambda-cloudwatch-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.rds-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.setupDB-lambda-cloudwatch-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.api_5xx_threshold](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.audit-deadLetterQueue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.customer-documents-deadLetterQueue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cognito_user_group.admin-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) | resource |
| [aws_cognito_user_group.non-admin-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) | resource |
| [aws_cognito_user_pool.user-pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.authorized-flow-client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_client.implicit-flow-client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.cognito-domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_dynamodb_table.organization-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.organization-table-](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_ecr_lifecycle_policy.default-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.sb-registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_iam_instance_profile.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.aws_ecs_task_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecs-instance-managed-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.iam-kms-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda-trigger-batch-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.APIGatwayCloudwatch-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.aws_batch_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.aws_ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cloudwatch-cron-log-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.index-document-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-apigateway-role-presigned-url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-apigateway-role-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-batch-trigger-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-rds-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-role-delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-role-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda-sqs-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudwatch-core-permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.corePermissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.corePermissions-delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.corePermissions-index-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.corePermissions-presigned-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.corePermissions-rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.corePermissions-s3Read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.corePermissions-s3ReadWrite](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.main-permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.APIGatwayCloudwatch-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_batch_service_role_policy_attachment_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_ecs_task_role_policy_attachment_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_ecs_task_role_policy_attachment_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.index-document-lambda-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-apigateway-role-presigned-url-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-apigateway-role-s3-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-batch-trigger-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-batch-trigger-role-policy-attachmentkms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-rds-role-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-role-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-role-delete-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-role-s3-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda-sqs-role-attach-kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.test-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_alias.populate_rds-trigger-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_alias.preSignUp-trigger-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_alias.setupDB-trigger-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.populate_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.preSignUp-trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.setupDB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.populate_rds-trigger-lambda-invoke-settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_function_event_invoke_config.preSignUp-trigger-lambda-invoke-settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_function_event_invoke_config.setupDB-trigger-lambda-invoke-settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_permission.allow_Cognito](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_rds_cluster.postgresql-rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_endpoint.static-read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_endpoint) | resource |
| [aws_rds_cluster_endpoint.static-write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_endpoint) | resource |
| [aws_rds_cluster_instance.main-cluster-instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_route53_record.api-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.customers-documents](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.logging-storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_notification.customer-documents-bucket-notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_policy.customer-documents-bucket-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.logging-storage-bucket-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_sqs_queue.audit-queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.customer-documents-queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.deadletter-audit-queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.deadletter-customer-documents-queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.audit-queue-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.customer-documents-queue-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.deadletter-audit-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.deadletter-customer-documents-queue-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_ssm_parameter.rds-master-password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [null_resource.init-rds](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.init-rds-with-profile](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate-rds](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate-rds-with-profile](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ApigatewayCloudwatch-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.SQS-access-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_batch_service_role_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_ecs_task_role_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch-core-permission-statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch-role-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.core-permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.core-permission-delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.core-permission-lambdas-s3-apigateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.core-permission-lambdas-s3-presigned-apigateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.core-permission-lambdas3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.core-rds-permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_instance_role_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_instance_role_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_instance_task_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam-kms-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.index-document-core-permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.index-document-lambda-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-api-gateway-presignedUrl-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-api-gateway-reads3-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-instance-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-instance-assume-role-policy-delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-rds-instance-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-s3-trigger-trust-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-s3readwrite-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-submit-batch-job-core-permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs-core-permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access-log-format"></a> [access-log-format](#input\_access-log-format) | n/a | `string` | n/a | yes |
| <a name="input_api-certificate-arn"></a> [api-certificate-arn](#input\_api-certificate-arn) | The AWS ACM certificate arn for API Gateway to utilize for HTTPS | `string` | n/a | yes |
| <a name="input_api-description"></a> [api-description](#input\_api-description) | n/a | `string` | n/a | yes |
| <a name="input_api-domain-name"></a> [api-domain-name](#input\_api-domain-name) | n/a | `string` | n/a | yes |
| <a name="input_api-name"></a> [api-name](#input\_api-name) | n/a | `string` | n/a | yes |
| <a name="input_api-stage-auto-deploy"></a> [api-stage-auto-deploy](#input\_api-stage-auto-deploy) | n/a | `bool` | n/a | yes |
| <a name="input_api-stage-name"></a> [api-stage-name](#input\_api-stage-name) | n/a | `string` | n/a | yes |
| <a name="input_api-version"></a> [api-version](#input\_api-version) | The version of the API | `string` | n/a | yes |
| <a name="input_auth-domain"></a> [auth-domain](#input\_auth-domain) | n/a | `string` | `""` | no |
| <a name="input_authorizer-type"></a> [authorizer-type](#input\_authorizer-type) | The default authentication type for API Gateway | `string` | `"JWT"` | no |
| <a name="input_batch-compute-type"></a> [batch-compute-type](#input\_batch-compute-type) | The type of the Batch compute environment | `string` | `"FARGATE_SPOT"` | no |
| <a name="input_batch-cpu"></a> [batch-cpu](#input\_batch-cpu) | The number of CPUs to allocated for the batch job | `string` | n/a | yes |
| <a name="input_batch-max-cpus"></a> [batch-max-cpus](#input\_batch-max-cpus) | The maximum number of CPUs to allocate for the Batch compute environment | `number` | `16` | no |
| <a name="input_batch-memory"></a> [batch-memory](#input\_batch-memory) | The memory size to allocated for the batch job | `string` | n/a | yes |
| <a name="input_batch-retry-attempts"></a> [batch-retry-attempts](#input\_batch-retry-attempts) | The number of times to retry the Batch job | `number` | `1` | no |
| <a name="input_batch-state"></a> [batch-state](#input\_batch-state) | Enable the AWS Batch compute environment | `string` | `"ENABLED"` | no |
| <a name="input_batch-type"></a> [batch-type](#input\_batch-type) | Specify if a compute environment is managed by AWS or manually | `string` | `"MANAGED"` | no |
| <a name="input_cognito-auto-verify-attrs"></a> [cognito-auto-verify-attrs](#input\_cognito-auto-verify-attrs) | The list of cogito attributes to auto-verify | `list(string)` | <pre>[<br>  "email"<br>]</pre> | no |
| <a name="input_cors-allow-headers"></a> [cors-allow-headers](#input\_cors-allow-headers) | n/a | `list(any)` | n/a | yes |
| <a name="input_cors-allow-methods"></a> [cors-allow-methods](#input\_cors-allow-methods) | n/a | `list(any)` | n/a | yes |
| <a name="input_cors-allow-origins"></a> [cors-allow-origins](#input\_cors-allow-origins) | n/a | `list(any)` | n/a | yes |
| <a name="input_cors-expose-headers"></a> [cors-expose-headers](#input\_cors-expose-headers) | n/a | `list(any)` | n/a | yes |
| <a name="input_db-subnets-ids"></a> [db-subnets-ids](#input\_db-subnets-ids) | The ids of subnets that are to be used for RDS | `list(string)` | n/a | yes |
| <a name="input_disable-default-endpoint"></a> [disable-default-endpoint](#input\_disable-default-endpoint) | Disable API Gateway default HTTP endpoint | `bool` | `true` | no |
| <a name="input_domain-name"></a> [domain-name](#input\_domain-name) | n/a | `string` | n/a | yes |
| <a name="input_dynamodb-billing-mode"></a> [dynamodb-billing-mode](#input\_dynamodb-billing-mode) | The billing mode for DynamoDB | `string` | n/a | yes |
| <a name="input_dynamodb-gsi-provisioning-read-capacity"></a> [dynamodb-gsi-provisioning-read-capacity](#input\_dynamodb-gsi-provisioning-read-capacity) | The read capacity to allocated for GSI | `number` | n/a | yes |
| <a name="input_dynamodb-gsi-provisioning-write-capacity"></a> [dynamodb-gsi-provisioning-write-capacity](#input\_dynamodb-gsi-provisioning-write-capacity) | The write capacity to allocated for GSI | `number` | n/a | yes |
| <a name="input_dynamodb-point-in-recovery"></a> [dynamodb-point-in-recovery](#input\_dynamodb-point-in-recovery) | Enable/Disable DynamoDB point in time recovery | `bool` | `false` | no |
| <a name="input_dynamodb-provisioning-read-capacity"></a> [dynamodb-provisioning-read-capacity](#input\_dynamodb-provisioning-read-capacity) | The read capacity to allocated | `number` | n/a | yes |
| <a name="input_dynamodb-provisioning-write-capacity"></a> [dynamodb-provisioning-write-capacity](#input\_dynamodb-provisioning-write-capacity) | The write capacity to allocated | `number` | n/a | yes |
| <a name="input_dynamodb-stream"></a> [dynamodb-stream](#input\_dynamodb-stream) | Enable/disable DynamoDB streams | `bool` | n/a | yes |
| <a name="input_ecr-image-tag-mutability"></a> [ecr-image-tag-mutability](#input\_ecr-image-tag-mutability) | Mutability setting for risk-sensing ECR repository | `string` | `"MUTABLE"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the infrastrcutrue (dev, test, prod) | `string` | n/a | yes |
| <a name="input_fargate-version"></a> [fargate-version](#input\_fargate-version) | The AWS Fargate version to use for batch jobs. | `string` | n/a | yes |
| <a name="input_iam-kms-grant-policy"></a> [iam-kms-grant-policy](#input\_iam-kms-grant-policy) | IAM policy that grants access to KMS key. | `string` | n/a | yes |
| <a name="input_kms-key-arn"></a> [kms-key-arn](#input\_kms-key-arn) | The KMS arn to use for encryption | `string` | n/a | yes |
| <a name="input_lambda-repository-region"></a> [lambda-repository-region](#input\_lambda-repository-region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_lambda-sqs-index-document-concurrency-limit"></a> [lambda-sqs-index-document-concurrency-limit](#input\_lambda-sqs-index-document-concurrency-limit) | Amount of capacity to allocate. Must be greater than or equal to 1 | `number` | n/a | yes |
| <a name="input_lambda-sqs-logging-concurrency-limit"></a> [lambda-sqs-logging-concurrency-limit](#input\_lambda-sqs-logging-concurrency-limit) | Amount of capacity to allocate. Must be greater than or equal to 1 | `number` | n/a | yes |
| <a name="input_logs-retention"></a> [logs-retention](#input\_logs-retention) | The number of days to retain CloudWatch logs | `number` | `3` | no |
| <a name="input_mfa_configuration"></a> [mfa\_configuration](#input\_mfa\_configuration) | Whether or not to enable MFA in AWS Cognito | `string` | `"ON"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix to use for infrastructure resources. | `string` | n/a | yes |
| <a name="input_newslit-api-key"></a> [newslit-api-key](#input\_newslit-api-key) | The Newslit API Key value | `string` | n/a | yes |
| <a name="input_org-email-domain"></a> [org-email-domain](#input\_org-email-domain) | The email domain of the organization | `string` | n/a | yes |
| <a name="input_org-id"></a> [org-id](#input\_org-id) | The organization id | `string` | n/a | yes |
| <a name="input_org-industry"></a> [org-industry](#input\_org-industry) | The industry of the organization | `string` | `"NONE"` | no |
| <a name="input_org-name"></a> [org-name](#input\_org-name) | The name of the organization | `string` | n/a | yes |
| <a name="input_org-size"></a> [org-size](#input\_org-size) | The employee size of the organization | `string` | `"42"` | no |
| <a name="input_passthrough-behavior"></a> [passthrough-behavior](#input\_passthrough-behavior) | n/a | `string` | n/a | yes |
| <a name="input_private-subnet-ids"></a> [private-subnet-ids](#input\_private-subnet-ids) | A list of private subnet ids | `list(string)` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | The AWS configuration profile to use | `any` | n/a | yes |
| <a name="input_protocol-type"></a> [protocol-type](#input\_protocol-type) | n/a | `string` | n/a | yes |
| <a name="input_rds-apply-immediately"></a> [rds-apply-immediately](#input\_rds-apply-immediately) | Apply RDS changes immediately | `bool` | n/a | yes |
| <a name="input_rds-az-list"></a> [rds-az-list](#input\_rds-az-list) | A list of availability zones to deploy RDS into. | `list(string)` | n/a | yes |
| <a name="input_rds-backup-retention-period"></a> [rds-backup-retention-period](#input\_rds-backup-retention-period) | The number of days to retain an RDS backup | `number` | n/a | yes |
| <a name="input_rds-db-master-password"></a> [rds-db-master-password](#input\_rds-db-master-password) | The RDS DB master password | `string` | n/a | yes |
| <a name="input_rds-db-name"></a> [rds-db-name](#input\_rds-db-name) | The DB name | `string` | n/a | yes |
| <a name="input_rds-db-port"></a> [rds-db-port](#input\_rds-db-port) | The RDS port that accepts network traffic. | `number` | n/a | yes |
| <a name="input_rds-db-subnet-name"></a> [rds-db-subnet-name](#input\_rds-db-subnet-name) | The the name of the DB subnet | `string` | n/a | yes |
| <a name="input_rds-delete-protection"></a> [rds-delete-protection](#input\_rds-delete-protection) | Enable RDS delete protection | `bool` | n/a | yes |
| <a name="input_rds-enable-public-ip"></a> [rds-enable-public-ip](#input\_rds-enable-public-ip) | Toggle a public IP to the RDS cluster | `bool` | n/a | yes |
| <a name="input_rds-instance-size"></a> [rds-instance-size](#input\_rds-instance-size) | The Amazon Aurora instance size to use | `string` | n/a | yes |
| <a name="input_rds-instances"></a> [rds-instances](#input\_rds-instances) | The number of RDS instances to deploy | `number` | n/a | yes |
| <a name="input_rds-maintenance-window"></a> [rds-maintenance-window](#input\_rds-maintenance-window) | The RDS maintenance to apply minor/major changes to. | `string` | n/a | yes |
| <a name="input_rds-postgres-engine"></a> [rds-postgres-engine](#input\_rds-postgres-engine) | The RDS postgres engine to utilize | `string` | n/a | yes |
| <a name="input_rds-postgres-engine-version"></a> [rds-postgres-engine-version](#input\_rds-postgres-engine-version) | The RDS postgres engine version to use. | `string` | n/a | yes |
| <a name="input_rds-preferred-backup-window"></a> [rds-preferred-backup-window](#input\_rds-preferred-backup-window) | The prefered window for RDS to create backup snapshots | `string` | n/a | yes |
| <a name="input_rds-read-role"></a> [rds-read-role](#input\_rds-read-role) | The read role for the RDS postgres database | `string` | n/a | yes |
| <a name="input_rds-write-role"></a> [rds-write-role](#input\_rds-write-role) | The write role for the RDS postgres database | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to use | `string` | n/a | yes |
| <a name="input_risk-sensing-image-version"></a> [risk-sensing-image-version](#input\_risk-sensing-image-version) | The version for the risk-sensing image to use | `string` | n/a | yes |
| <a name="input_route-timeout"></a> [route-timeout](#input\_route-timeout) | n/a | `number` | n/a | yes |
| <a name="input_s3-force-destroy"></a> [s3-force-destroy](#input\_s3-force-destroy) | Enable S3 Force destroy | `bool` | `false` | no |
| <a name="input_sawyer-version"></a> [sawyer-version](#input\_sawyer-version) | The version of sawyer to use | `string` | `"latest"` | no |
| <a name="input_security-group-ids"></a> [security-group-ids](#input\_security-group-ids) | A list of security group ids | `list(string)` | n/a | yes |
| <a name="input_security-policy"></a> [security-policy](#input\_security-policy) | The TLS policy to apply to the API Gateway domain | `string` | n/a | yes |
| <a name="input_ses-email-arn"></a> [ses-email-arn](#input\_ses-email-arn) | The ARN of the SES email to utilize | `string` | n/a | yes |
| <a name="input_software_token_mfa_configuration_enabled"></a> [software\_token\_mfa\_configuration\_enabled](#input\_software\_token\_mfa\_configuration\_enabled) | Whether or not to enable mfa via software token | `bool` | `true` | no |
| <a name="input_support-sns-topic"></a> [support-sns-topic](#input\_support-sns-topic) | The SNS topic to leverage for support purposes | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of commonly used tags | `map(any)` | n/a | yes |
| <a name="input_tracing-mode"></a> [tracing-mode](#input\_tracing-mode) | n/a | `string` | n/a | yes |
| <a name="input_vpc-id"></a> [vpc-id](#input\_vpc-id) | The VPC ID to use. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ApiGateway-domain-api_mapping_selection_expression"></a> [ApiGateway-domain-api\_mapping\_selection\_expression](#output\_ApiGateway-domain-api\_mapping\_selection\_expression) | n/a |
| <a name="output_ApiGateway-domain-arn"></a> [ApiGateway-domain-arn](#output\_ApiGateway-domain-arn) | n/a |
| <a name="output_ApiGateway-domain-id"></a> [ApiGateway-domain-id](#output\_ApiGateway-domain-id) | n/a |
| <a name="output_api-gateway-authorizer-id"></a> [api-gateway-authorizer-id](#output\_api-gateway-authorizer-id) | n/a |
| <a name="output_api-target-domain"></a> [api-target-domain](#output\_api-target-domain) | n/a |
| <a name="output_apigateway-delete-role-arn"></a> [apigateway-delete-role-arn](#output\_apigateway-delete-role-arn) | n/a |
| <a name="output_apigateway-presigned-role-arn"></a> [apigateway-presigned-role-arn](#output\_apigateway-presigned-role-arn) | n/a |
| <a name="output_apigateway-s3-role-arn"></a> [apigateway-s3-role-arn](#output\_apigateway-s3-role-arn) | n/a |
| <a name="output_audit-sqs-arn"></a> [audit-sqs-arn](#output\_audit-sqs-arn) | n/a |
| <a name="output_audit-sqs-url"></a> [audit-sqs-url](#output\_audit-sqs-url) | ########################################## SQS ########################################### |
| <a name="output_aurora-db-arn"></a> [aurora-db-arn](#output\_aurora-db-arn) | n/a |
| <a name="output_aurora-db-cluster-resource-id"></a> [aurora-db-cluster-resource-id](#output\_aurora-db-cluster-resource-id) | n/a |
| <a name="output_aurora-db-custom-reader-endpoint"></a> [aurora-db-custom-reader-endpoint](#output\_aurora-db-custom-reader-endpoint) | n/a |
| <a name="output_aurora-db-custom-writer-endpoint"></a> [aurora-db-custom-writer-endpoint](#output\_aurora-db-custom-writer-endpoint) | n/a |
| <a name="output_aurora-db-endpoint"></a> [aurora-db-endpoint](#output\_aurora-db-endpoint) | n/a |
| <a name="output_aurora-db-id"></a> [aurora-db-id](#output\_aurora-db-id) | n/a |
| <a name="output_aurora-db-identifier"></a> [aurora-db-identifier](#output\_aurora-db-identifier) | n/a |
| <a name="output_aurora-db-reader-endpoint"></a> [aurora-db-reader-endpoint](#output\_aurora-db-reader-endpoint) | n/a |
| <a name="output_aurora-db-reader-r53-hosted-zone"></a> [aurora-db-reader-r53-hosted-zone](#output\_aurora-db-reader-r53-hosted-zone) | n/a |
| <a name="output_authorized-flow-client-id"></a> [authorized-flow-client-id](#output\_authorized-flow-client-id) | n/a |
| <a name="output_batch-compute-environment-arn"></a> [batch-compute-environment-arn](#output\_batch-compute-environment-arn) | ########################################### AWS Batch ############################################ |
| <a name="output_batch-compute-environment-ecs-cluster-arn"></a> [batch-compute-environment-ecs-cluster-arn](#output\_batch-compute-environment-ecs-cluster-arn) | n/a |
| <a name="output_batch-compute-environment-job-definition-arn"></a> [batch-compute-environment-job-definition-arn](#output\_batch-compute-environment-job-definition-arn) | n/a |
| <a name="output_batch-compute-queue-arn"></a> [batch-compute-queue-arn](#output\_batch-compute-queue-arn) | n/a |
| <a name="output_cloudwatch-cron-role"></a> [cloudwatch-cron-role](#output\_cloudwatch-cron-role) | n/a |
| <a name="output_cluster-identifier"></a> [cluster-identifier](#output\_cluster-identifier) | n/a |
| <a name="output_customer-documents-bucket-id"></a> [customer-documents-bucket-id](#output\_customer-documents-bucket-id) | ################################## S3 ################################### |
| <a name="output_customer-sqs-arn"></a> [customer-sqs-arn](#output\_customer-sqs-arn) | n/a |
| <a name="output_customer-sqs-url"></a> [customer-sqs-url](#output\_customer-sqs-url) | n/a |
| <a name="output_implicit-client-id"></a> [implicit-client-id](#output\_implicit-client-id) | n/a |
| <a name="output_lambda-batch-trigger-role-arn"></a> [lambda-batch-trigger-role-arn](#output\_lambda-batch-trigger-role-arn) | n/a |
| <a name="output_lambda-index-documents-role-arn"></a> [lambda-index-documents-role-arn](#output\_lambda-index-documents-role-arn) | n/a |
| <a name="output_lambda-rds-role-arn"></a> [lambda-rds-role-arn](#output\_lambda-rds-role-arn) | n/a |
| <a name="output_lambda-s3-role-arn"></a> [lambda-s3-role-arn](#output\_lambda-s3-role-arn) | n/a |
| <a name="output_lambda-sqs-role-arn"></a> [lambda-sqs-role-arn](#output\_lambda-sqs-role-arn) | n/a |
| <a name="output_logging-bucket-id"></a> [logging-bucket-id](#output\_logging-bucket-id) | n/a |
| <a name="output_main-api-arn"></a> [main-api-arn](#output\_main-api-arn) | n/a |
| <a name="output_main-api-endpoint"></a> [main-api-endpoint](#output\_main-api-endpoint) | n/a |
| <a name="output_main-api-execution-arn"></a> [main-api-execution-arn](#output\_main-api-execution-arn) | n/a |
| <a name="output_main-api-id"></a> [main-api-id](#output\_main-api-id) | ############################# API Gateway SawyerBrink API ############################# |
| <a name="output_main-api-mapping"></a> [main-api-mapping](#output\_main-api-mapping) | n/a |
| <a name="output_main-api-stage-arn"></a> [main-api-stage-arn](#output\_main-api-stage-arn) | n/a |
| <a name="output_main-api-stage-id"></a> [main-api-stage-id](#output\_main-api-stage-id) | n/a |
| <a name="output_main-api-stage-invoke-url"></a> [main-api-stage-invoke-url](#output\_main-api-stage-invoke-url) | n/a |
| <a name="output_main-lambda-role-arn"></a> [main-lambda-role-arn](#output\_main-lambda-role-arn) | #################################### IAM Roles ###################################### |
| <a name="output_organization-table-arn"></a> [organization-table-arn](#output\_organization-table-arn) | n/a |
| <a name="output_organization-table-id"></a> [organization-table-id](#output\_organization-table-id) | ####################### Organization Table ####################### |
| <a name="output_organization-table-stream-arn"></a> [organization-table-stream-arn](#output\_organization-table-stream-arn) | n/a |
| <a name="output_user-pool-arn"></a> [user-pool-arn](#output\_user-pool-arn) | n/a |
| <a name="output_user-pool-endpoint"></a> [user-pool-endpoint](#output\_user-pool-endpoint) | n/a |
| <a name="output_user-pool-id"></a> [user-pool-id](#output\_user-pool-id) | ############################# Cognito ############################# |
