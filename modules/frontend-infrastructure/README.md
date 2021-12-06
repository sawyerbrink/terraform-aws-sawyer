## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >3.0.0 |
| <a name="provider_aws.dr"></a> [aws.dr](#provider\_aws.dr) | >3.0.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ../cloudfront | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.build-website-cloudwatch-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda-website-build-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.s3-replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.role-permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_alias.build-website-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.build-website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.build-website-lambda-invoke-settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_s3_bucket.code-storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.code-storage-DR](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [local_file.s3-replication-config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.build-website](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.build-website-with-profile](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.enable-crr](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.enable-crr-profile](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_acm_certificate.ui-cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_iam_policy_document.iam-permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-website-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda-website-permissions-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The account number that Sawyer is getting deployed to. | `string` | n/a | yes |
| <a name="input_api-url"></a> [api-url](#input\_api-url) | The API URL to use | `string` | n/a | yes |
| <a name="input_api-version"></a> [api-version](#input\_api-version) | The API version | `string` | n/a | yes |
| <a name="input_cognito-userpool-client-id"></a> [cognito-userpool-client-id](#input\_cognito-userpool-client-id) | The Cognito userpool web client id | `string` | n/a | yes |
| <a name="input_cognito-userpool-id"></a> [cognito-userpool-id](#input\_cognito-userpool-id) | The Cognito userpool id generated for Sawyer | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_dr-region"></a> [dr-region](#input\_dr-region) | The AWS DR region to use | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the infrastrcutrue (dev, test, prod) | `string` | n/a | yes |
| <a name="input_kms-key-arn"></a> [kms-key-arn](#input\_kms-key-arn) | The KMS arn to use for encryption | `string` | n/a | yes |
| <a name="input_logs-retention"></a> [logs-retention](#input\_logs-retention) | The number of days to retain logs | `number` | `3` | no |
| <a name="input_min-tls-version"></a> [min-tls-version](#input\_min-tls-version) | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name prefix to use for infrastructure resources. | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | The AWS configuration profile to use | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to use | `string` | n/a | yes |
| <a name="input_sawyer-version"></a> [sawyer-version](#input\_sawyer-version) | The version of sawyer to use | `string` | `"1.0.0"` | no |
| <a name="input_url-prefix"></a> [url-prefix](#input\_url-prefix) | The url prefix for the website | `string` | `"ui"` | no |
| <a name="input_website-build-lambda-memory-size"></a> [website-build-lambda-memory-size](#input\_website-build-lambda-memory-size) | The memory size of the Lambda that builds the website assets | `number` | `128` | no |
| <a name="input_website-repository-region"></a> [website-repository-region](#input\_website-repository-region) | n/a | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
