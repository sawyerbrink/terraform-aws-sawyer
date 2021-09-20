output "arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = aws_lambda_function.lambda.arn
}

output "qualified-arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)"
  value       = aws_lambda_function.lambda.qualified_arn
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
  value       = aws_lambda_function.lambda.invoke_arn
}

output "version" {
  description = "Latest published version of your Lambda Function."
  value       = aws_lambda_function.lambda.version
}

output "last_modified" {
  value = aws_lambda_function.lambda.last_modified
}

output "kms_key_arn_lambda" {
  description = "The ARN for the KMS encryption key."
  value       = aws_lambda_function.lambda.kms_key_arn
}

output "source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
  value       = aws_lambda_function.lambda.source_code_hash
}

output "source_code_size" {
  description = "The size in bytes of the function .zip file."
  value       = aws_lambda_function.lambda.source_code_size
}

output "alias-arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda function alias."
  value       = aws_lambda_alias.lambda-alias.arn
}

output "alias_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
  value       = aws_lambda_alias.lambda-alias.invoke_arn
}