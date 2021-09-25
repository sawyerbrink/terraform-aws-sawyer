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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.access-origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_cloudfront_origin_access_identity.access-origin-dr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_route53_record.cloudfront-record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket_policy.logging-storage-bucket-dr-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.logging-storage-bucket-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sb-s3-spa-dr-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sb-s3-spa-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_s3_bucket.source-code](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_s3_bucket.source-code-dr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application name - DO NOT USE SPACES. This will be the url of that the end user will use to interact with Sawyer. | `string` | n/a | yes |
| <a name="input_bucket-dr-name"></a> [bucket-dr-name](#input\_bucket-dr-name) | The name of the disater recovery bucket that contains the source code | `string` | n/a | yes |
| <a name="input_bucket-name"></a> [bucket-name](#input\_bucket-name) | The name of the bucket that contains the source code | `string` | n/a | yes |
| <a name="input_cache_items"></a> [cache\_items](#input\_cache\_items) | File glob patterns to be cached in CloudFront | `list(string)` | `[]` | no |
| <a name="input_certificate-arn"></a> [certificate-arn](#input\_certificate-arn) | The arn of the ACM certificate to apply to the CloudFront distribution. | `string` | n/a | yes |
| <a name="input_custom_error_response"></a> [custom\_error\_response](#input\_custom\_error\_response) | Custom error responses | `list(map(string))` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy the application to | `string` | n/a | yes |
| <a name="input_error_document"></a> [error\_document](#input\_error\_document) | Error document that will be used for an error page | `string` | `null` | no |
| <a name="input_hosted-zone-name"></a> [hosted-zone-name](#input\_hosted-zone-name) | The name of the route53 hosted zone that the SPA belongs to | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections | `string` | `"TLSv1.2_2021"` | no |
| <a name="input_price-class"></a> [price-class](#input\_price-class) | The CloudFront price class to apply | `string` | `"PriceClass_100"` | no |
| <a name="input_root-document"></a> [root-document](#input\_root-document) | Root document that will be the main entry point for the SPA | `string` | `"index.html"` | no |
| <a name="input_s3-replication-role-arn"></a> [s3-replication-role-arn](#input\_s3-replication-role-arn) | The S3 replication role to apply to the generated bucket policies | `string` | n/a | yes |
| <a name="input_url-prefix"></a> [url-prefix](#input\_url-prefix) | The url prfix to the website | `string` | n/a | yes |
| <a name="input_web-acl-id"></a> [web-acl-id](#input\_web-acl-id) | The ID of a WAF ACL to be applied | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront-arn"></a> [cloudfront-arn](#output\_cloudfront-arn) | n/a |
| <a name="output_cloudfront-caller-reference"></a> [cloudfront-caller-reference](#output\_cloudfront-caller-reference) | n/a |
| <a name="output_cloudfront-etag"></a> [cloudfront-etag](#output\_cloudfront-etag) | n/a |
| <a name="output_cloudfront-hosted-zone-id"></a> [cloudfront-hosted-zone-id](#output\_cloudfront-hosted-zone-id) | n/a |
| <a name="output_cloudfront-id"></a> [cloudfront-id](#output\_cloudfront-id) | n/a |
| <a name="output_cloudfront-status"></a> [cloudfront-status](#output\_cloudfront-status) | n/a |
| <a name="output_local-url"></a> [local-url](#output\_local-url) | n/a |
| <a name="output_orgin-access-identity-arn"></a> [orgin-access-identity-arn](#output\_orgin-access-identity-arn) | n/a |
| <a name="output_orgin-access-identity-id"></a> [orgin-access-identity-id](#output\_orgin-access-identity-id) | n/a |
| <a name="output_orgin-access-identity-s3-user-id"></a> [orgin-access-identity-s3-user-id](#output\_orgin-access-identity-s3-user-id) | n/a |
