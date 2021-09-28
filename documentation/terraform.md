## Examples

Example usage and code is available in the [examples](../examples) folder.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend-api-functions"></a> [backend-api-functions](#module\_backend-api-functions) | ./modules/backend-api-functions | n/a |
| <a name="module_backend-api-infrastructure"></a> [backend-api-infrastructure](#module\_backend-api-infrastructure) | ./modules/backend-api-infrastructure | n/a |
| <a name="module_frontend-infrastructure"></a> [frontend-infrastructure](#module\_frontend-infrastructure) | ./modules/frontend-infrastructure | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.db-password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backendinfra-access-log-format"></a> [backendinfra-access-log-format](#input\_backendinfra-access-log-format) | n/a | `string` | `"{ \"ApiId\": \"$context.apiId\" , \"requestId\":\"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"userName\": \"$context.authorizer.claims.username\", \"authorizerError\": \"$context.authorizer.error\", \"authorizerLatency\": \"$context.authorizer.latency\", \"authorizerStatus\": \"$context.authorizer.status\", \"requestTime\":\"$context.requestTime\",\"httpMethod\":\"$context.httpMethod\",\"userAgent\":\"$context.identity.userAgent\",\"routeKey\":\"$context.routeKey\",\"path\":\"$context.path\",\"stage\":\"$context.stage\", \"status\":\"$context.status\", \"intergrationLatency\": \"$context.integrationLatency\", \"responseLatency\": \"$context.responseLatency\", \"protocol\":\"$context.protocol\", \"responseLength\":\"$context.responseLength\", \"domainName\": \"$context.domainName \",\"errorMessage\": \"$context.error.message\", \"integrationErrorMessage\": \"$context.integrationErrorMessage\"}"` | no |
| <a name="input_backendinfra-api-certificate-arn"></a> [backendinfra-api-certificate-arn](#input\_backendinfra-api-certificate-arn) | The AWS ACM certificate arn for API Gateway to utilize for HTTPS | `string` | n/a | yes |
| <a name="input_backendinfra-api-description"></a> [backendinfra-api-description](#input\_backendinfra-api-description) | n/a | `string` | `"The Saywer API for risk and governance management"` | no |
| <a name="input_backendinfra-api-domain-name"></a> [backendinfra-api-domain-name](#input\_backendinfra-api-domain-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-api-name"></a> [backendinfra-api-name](#input\_backendinfra-api-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-api-stage-auto-deploy"></a> [backendinfra-api-stage-auto-deploy](#input\_backendinfra-api-stage-auto-deploy) | n/a | `bool` | `true` | no |
| <a name="input_backendinfra-api-stage-name"></a> [backendinfra-api-stage-name](#input\_backendinfra-api-stage-name) | n/a | `string` | `"default"` | no |
| <a name="input_backendinfra-api-version"></a> [backendinfra-api-version](#input\_backendinfra-api-version) | The version of the API | `string` | n/a | yes |
| <a name="input_backendinfra-auth-domain"></a> [backendinfra-auth-domain](#input\_backendinfra-auth-domain) | n/a | `string` | `""` | no |
| <a name="input_backendinfra-authorizer-type"></a> [backendinfra-authorizer-type](#input\_backendinfra-authorizer-type) | The default authentication type for API Gateway | `string` | `"JWT"` | no |
| <a name="input_backendinfra-batch-compute-type"></a> [backendinfra-batch-compute-type](#input\_backendinfra-batch-compute-type) | The type of the Batch compute environment | `string` | `"FARGATE_SPOT"` | no |
| <a name="input_backendinfra-batch-cpu"></a> [backendinfra-batch-cpu](#input\_backendinfra-batch-cpu) | The number of CPUs to allocated for the batch job | `string` | `"2"` | no |
| <a name="input_backendinfra-batch-max-cpus"></a> [backendinfra-batch-max-cpus](#input\_backendinfra-batch-max-cpus) | The maximum number of CPUs to allocate for the Batch compute environment | `number` | `16` | no |
| <a name="input_backendinfra-batch-memory"></a> [backendinfra-batch-memory](#input\_backendinfra-batch-memory) | The memory size to allocated for the batch job | `string` | `"6144"` | no |
| <a name="input_backendinfra-batch-retry-attempts"></a> [backendinfra-batch-retry-attempts](#input\_backendinfra-batch-retry-attempts) | The number of times to retry the Batch job | `number` | `1` | no |
| <a name="input_backendinfra-batch-state"></a> [backendinfra-batch-state](#input\_backendinfra-batch-state) | Enable the AWS Batch compute environment | `string` | `"ENABLED"` | no |
| <a name="input_backendinfra-batch-type"></a> [backendinfra-batch-type](#input\_backendinfra-batch-type) | Specify if a compute environment is managed by AWS or manually | `string` | `"MANAGED"` | no |
| <a name="input_backendinfra-cors-allow-headers"></a> [backendinfra-cors-allow-headers](#input\_backendinfra-cors-allow-headers) | n/a | `list(any)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_backendinfra-cors-allow-methods"></a> [backendinfra-cors-allow-methods](#input\_backendinfra-cors-allow-methods) | n/a | `list(any)` | <pre>[<br>  "GET",<br>  "PUT",<br>  "POST",<br>  "DELETE",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_backendinfra-cors-allow-origins"></a> [backendinfra-cors-allow-origins](#input\_backendinfra-cors-allow-origins) | n/a | `list(any)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_backendinfra-cors-expose-headers"></a> [backendinfra-cors-expose-headers](#input\_backendinfra-cors-expose-headers) | n/a | `list(any)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_backendinfra-db-subnets-ids"></a> [backendinfra-db-subnets-ids](#input\_backendinfra-db-subnets-ids) | The ids of subnets that are to be used for RDS | `list(string)` | n/a | yes |
| <a name="input_backendinfra-disable-default-endpoint"></a> [backendinfra-disable-default-endpoint](#input\_backendinfra-disable-default-endpoint) | Disable API Gateway default HTTP endpoint | `bool` | `true` | no |
| <a name="input_backendinfra-domain-name"></a> [backendinfra-domain-name](#input\_backendinfra-domain-name) | n/a | `string` | n/a | yes |
| <a name="input_backendinfra-ds-db-master-password"></a> [backendinfra-ds-db-master-password](#input\_backendinfra-ds-db-master-password) | The RDS DB master password | `string` | `""` | no |
| <a name="input_backendinfra-dynamodb-billing-mode"></a> [backendinfra-dynamodb-billing-mode](#input\_backendinfra-dynamodb-billing-mode) | The DynomoDB billing mode to use | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_backendinfra-dynamodb-gsi-provisioning-read-capacity"></a> [backendinfra-dynamodb-gsi-provisioning-read-capacity](#input\_backendinfra-dynamodb-gsi-provisioning-read-capacity) | The read capacity to allocated for GSI | `number` | `10` | no |
| <a name="input_backendinfra-dynamodb-gsi-provisioning-write-capacity"></a> [backendinfra-dynamodb-gsi-provisioning-write-capacity](#input\_backendinfra-dynamodb-gsi-provisioning-write-capacity) | The write capacity to allocated for GSI | `number` | `4` | no |
| <a name="input_backendinfra-dynamodb-point-in-recovery"></a> [backendinfra-dynamodb-point-in-recovery](#input\_backendinfra-dynamodb-point-in-recovery) | Enable/Disable DynamoDB point in time recovery | `bool` | `false` | no |
| <a name="input_backendinfra-dynamodb-provisioning-read-capacity"></a> [backendinfra-dynamodb-provisioning-read-capacity](#input\_backendinfra-dynamodb-provisioning-read-capacity) | The read capacity to allocated | `number` | `6` | no |
| <a name="input_backendinfra-dynamodb-provisioning-write-capacity"></a> [backendinfra-dynamodb-provisioning-write-capacity](#input\_backendinfra-dynamodb-provisioning-write-capacity) | The write capacity to allocated | `number` | `10` | no |
| <a name="input_backendinfra-dynamodb-stream"></a> [backendinfra-dynamodb-stream](#input\_backendinfra-dynamodb-stream) | Enable/disable DynamoDB streams | `bool` | `false` | no |
| <a name="input_backendinfra-ecr-image-tag-mutability"></a> [backendinfra-ecr-image-tag-mutability](#input\_backendinfra-ecr-image-tag-mutability) | Mutability setting for the ECR generated repository | `string` | `"MUTABLE"` | no |
| <a name="input_backendinfra-enable-audit-logging"></a> [backendinfra-enable-audit-logging](#input\_backendinfra-enable-audit-logging) | Enable audit logging | `bool` | `true` | no |
| <a name="input_backendinfra-environment"></a> [backendinfra-environment](#input\_backendinfra-environment) | The environment for the infrastrcutrue (dev, test, prod) | `string` | n/a | yes |
| <a name="input_backendinfra-fargate-version"></a> [backendinfra-fargate-version](#input\_backendinfra-fargate-version) | The AWS Fargate version to use for batch jobs. | `string` | `"1.4.0"` | no |
| <a name="input_backendinfra-iam-kms-grant-policy"></a> [backendinfra-iam-kms-grant-policy](#input\_backendinfra-iam-kms-grant-policy) | IAM policy that grants access to KMS key. | `string` | `""` | no |
| <a name="input_backendinfra-lambda-security-groups-ids"></a> [backendinfra-lambda-security-groups-ids](#input\_backendinfra-lambda-security-groups-ids) | A list of security groups to apply to all Sawyer Lambdas | `list(string)` | `[]` | no |
| <a name="input_backendinfra-lambda-sqs-index-document-concurrency-limit"></a> [backendinfra-lambda-sqs-index-document-concurrency-limit](#input\_backendinfra-lambda-sqs-index-document-concurrency-limit) | Amount of capacity to allocate. Must be greater than or equal to 1 | `number` | `10` | no |
| <a name="input_backendinfra-lambda-sqs-logging-concurrency-limit"></a> [backendinfra-lambda-sqs-logging-concurrency-limit](#input\_backendinfra-lambda-sqs-logging-concurrency-limit) | Amount of capacity to allocate. Must be greater than or equal to 1 | `number` | `10` | no |
| <a name="input_backendinfra-lambda-subnet-ids"></a> [backendinfra-lambda-subnet-ids](#input\_backendinfra-lambda-subnet-ids) | A list of subnet ids to associate Lambdas with. Required for accessing RDS | `list(string)` | `[]` | no |
| <a name="input_backendinfra-passthrough-behavior"></a> [backendinfra-passthrough-behavior](#input\_backendinfra-passthrough-behavior) | The API Gateway Passthough behavior | `string` | `"WHEN_NO_MATCH"` | no |
| <a name="input_backendinfra-private-subnet-ids"></a> [backendinfra-private-subnet-ids](#input\_backendinfra-private-subnet-ids) | A list of private subnet ids | `list(string)` | n/a | yes |
| <a name="input_backendinfra-protocol-type"></a> [backendinfra-protocol-type](#input\_backendinfra-protocol-type) | The API Gateway Protocol | `string` | `"HTTP"` | no |
| <a name="input_backendinfra-rds-apply-immediately"></a> [backendinfra-rds-apply-immediately](#input\_backendinfra-rds-apply-immediately) | Apply RDS changes immediately | `bool` | `false` | no |
| <a name="input_backendinfra-rds-az-list"></a> [backendinfra-rds-az-list](#input\_backendinfra-rds-az-list) | A list of availability zones to deploy RDS into. | `list(string)` | `[]` | no |
| <a name="input_backendinfra-rds-backup-retention-period"></a> [backendinfra-rds-backup-retention-period](#input\_backendinfra-rds-backup-retention-period) | The number of days to retain an RDS backup | `number` | `7` | no |
| <a name="input_backendinfra-rds-db-name"></a> [backendinfra-rds-db-name](#input\_backendinfra-rds-db-name) | The DB name | `string` | `"sawyer"` | no |
| <a name="input_backendinfra-rds-db-port"></a> [backendinfra-rds-db-port](#input\_backendinfra-rds-db-port) | The RDS port that accepts network traffic. | `number` | `5432` | no |
| <a name="input_backendinfra-rds-db-subnet-name"></a> [backendinfra-rds-db-subnet-name](#input\_backendinfra-rds-db-subnet-name) | The the name of the DB subnet | `string` | n/a | yes |
| <a name="input_backendinfra-rds-delete-protection"></a> [backendinfra-rds-delete-protection](#input\_backendinfra-rds-delete-protection) | Enable RDS deletion protection | `bool` | `false` | no |
| <a name="input_backendinfra-rds-enable-public-ip"></a> [backendinfra-rds-enable-public-ip](#input\_backendinfra-rds-enable-public-ip) | Toggle a public IP to the RDS cluster | `bool` | `false` | no |
| <a name="input_backendinfra-rds-instance-size"></a> [backendinfra-rds-instance-size](#input\_backendinfra-rds-instance-size) | The Amazon Aurora instance size to use | `string` | `"db.t3.medium"` | no |
| <a name="input_backendinfra-rds-instances"></a> [backendinfra-rds-instances](#input\_backendinfra-rds-instances) | The number of RDS instances to deploy | `number` | `1` | no |
| <a name="input_backendinfra-rds-maintenance-window"></a> [backendinfra-rds-maintenance-window](#input\_backendinfra-rds-maintenance-window) | The RDS maintenance to apply minor/major changes to. | `string` | `"Fri:23:00-Sat:02:00"` | no |
| <a name="input_backendinfra-rds-postgres-engine"></a> [backendinfra-rds-postgres-engine](#input\_backendinfra-rds-postgres-engine) | The RDS postgres engine to utilize | `string` | `"aurora-postgresql"` | no |
| <a name="input_backendinfra-rds-postgres-engine-version"></a> [backendinfra-rds-postgres-engine-version](#input\_backendinfra-rds-postgres-engine-version) | The RDS postgres engine version to use. | `string` | `"12.4"` | no |
| <a name="input_backendinfra-rds-preferred-backup-window"></a> [backendinfra-rds-preferred-backup-window](#input\_backendinfra-rds-preferred-backup-window) | The prefered window for RDS to create backup snapshots | `string` | `"02:15-03:00"` | no |
| <a name="input_backendinfra-rds-read-role"></a> [backendinfra-rds-read-role](#input\_backendinfra-rds-read-role) | The read role for the RDS postgres database | `string` | `"app_read_role"` | no |
| <a name="input_backendinfra-rds-write-role"></a> [backendinfra-rds-write-role](#input\_backendinfra-rds-write-role) | The write role for the RDS postgres database | `string` | `"app_write_role"` | no |
| <a name="input_backendinfra-risk-sensing-image-version"></a> [backendinfra-risk-sensing-image-version](#input\_backendinfra-risk-sensing-image-version) | The version for the risk-sensing image to use | `string` | `"latest"` | no |
| <a name="input_backendinfra-route-timeout"></a> [backendinfra-route-timeout](#input\_backendinfra-route-timeout) | n/a | `number` | `29000` | no |
| <a name="input_backendinfra-s3-force-destroy"></a> [backendinfra-s3-force-destroy](#input\_backendinfra-s3-force-destroy) | Enable S3 Force destroy | `bool` | `false` | no |
| <a name="input_backendinfra-security-group-ids"></a> [backendinfra-security-group-ids](#input\_backendinfra-security-group-ids) | A list of security group ids | `list(string)` | n/a | yes |
| <a name="input_backendinfra-security-policy"></a> [backendinfra-security-policy](#input\_backendinfra-security-policy) | The TLS policy to apply to the API Gateway domain | `string` | n/a | yes |
| <a name="input_backendinfra-support-sns-topic"></a> [backendinfra-support-sns-topic](#input\_backendinfra-support-sns-topic) | The SNS topic to leverage for support purposes | `string` | n/a | yes |
| <a name="input_backendinfra-tracing-mode"></a> [backendinfra-tracing-mode](#input\_backendinfra-tracing-mode) | The API Gateway tracing to enable | `string` | `"Active"` | no |
| <a name="input_backendinfra-vpc-id"></a> [backendinfra-vpc-id](#input\_backendinfra-vpc-id) | The VPC ID to deploy Sawyer resources into. | `string` | n/a | yes |
| <a name="input_dr-region"></a> [dr-region](#input\_dr-region) | The AWS disaster region to use | `string` | n/a | yes |
| <a name="input_frontendinfra-min-tls-version"></a> [frontendinfra-min-tls-version](#input\_frontendinfra-min-tls-version) | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections | `string` | `"TLSv1.2_2021"` | no |
| <a name="input_kms-key-arn"></a> [kms-key-arn](#input\_kms-key-arn) | The KMS arn to use for encryption | `string` | n/a | yes |
| <a name="input_lambda-publish"></a> [lambda-publish](#input\_lambda-publish) | Setting to enable Lambda publishing | `bool` | `true` | no |
| <a name="input_lambda-repository-region"></a> [lambda-repository-region](#input\_lambda-repository-region) | n/a | `string` | n/a | yes |
| <a name="input_logs-retention"></a> [logs-retention](#input\_logs-retention) | The number of days to retain logs | `number` | `3` | no |
| <a name="input_name"></a> [name](#input\_name) | The global name of the owner. This could be a company, owning team, or area name. A default name will be provided if not specified. | `string` | `""` | no |
| <a name="input_newslit-api-key"></a> [newslit-api-key](#input\_newslit-api-key) | The Newslit API Key value | `string` | n/a | yes |
| <a name="input_org-email-domain"></a> [org-email-domain](#input\_org-email-domain) | The email domain of the organization | `string` | n/a | yes |
| <a name="input_org-industry"></a> [org-industry](#input\_org-industry) | The industry of the organization | `string` | `"NONE"` | no |
| <a name="input_org-name"></a> [org-name](#input\_org-name) | The name of the organization | `string` | n/a | yes |
| <a name="input_org-size"></a> [org-size](#input\_org-size) | The employee size of the organization | `string` | `"42"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | The AWS configuration profile to use | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to use | `string` | n/a | yes |
| <a name="input_sawyer-version"></a> [sawyer-version](#input\_sawyer-version) | The version of sawyer to use | `string` | n/a | yes |
| <a name="input_ses-email-arn"></a> [ses-email-arn](#input\_ses-email-arn) | The ARN of the SES email to utilize. If empty the default Cognito email will be used. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of commonly used tags | `map(any)` | n/a | yes |
| <a name="input_website-repository-region"></a> [website-repository-region](#input\_website-repository-region) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
