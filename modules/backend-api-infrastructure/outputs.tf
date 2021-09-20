########################
# Organization Table
########################
output "organization-table-id" {
  value = aws_dynamodb_table.organization-table[0].id
}

output "organization-table-arn" {
  value = aws_dynamodb_table.organization-table[0].arn
}

output "organization-table-stream-arn" {
  value = aws_dynamodb_table.organization-table[0].stream_arn
}
##############################
# Cognito
##############################
output "user-pool-id" {
  value = aws_cognito_user_pool.user-pool.id
}

output "user-pool-arn" {
  value = aws_cognito_user_pool.user-pool.arn
}

output "user-pool-endpoint" {
  value = aws_cognito_user_pool.user-pool.endpoint
}

output "implicit-client-id" {
  value = aws_cognito_user_pool_client.implicit-flow-client.id
}

output "authorized-flow-client-id" {
  value = aws_cognito_user_pool_client.authorized-flow-client.id
}

##############################
# API Gateway SawyerBrink API
##############################
output "main-api-id" {
  value = module.apigateway-core.main-api-id
}

output "main-api-endpoint" {
  value = module.apigateway-core.main-api-endpoint
}

output "main-api-arn" {
  value = module.apigateway-core.main-api-endpoint
}

output "main-api-stage-id" {
  value = module.apigateway-core.main-api-stage-id
}

output "main-api-stage-arn" {
  value = module.apigateway-core.main-api-stage-arn
}

output "main-api-execution-arn" {
  value = module.apigateway-core.main-api-execution-arn
}

output "main-api-stage-invoke-url" {
  value = module.apigateway-core.main-api-stage-invoke-url
}

output "ApiGateway-domain-id" {
  value = aws_apigatewayv2_domain_name.api-sawyerbrink.id
}

output "ApiGateway-domain-api_mapping_selection_expression" {
  value = aws_apigatewayv2_domain_name.api-sawyerbrink.api_mapping_selection_expression
}

output "ApiGateway-domain-arn" {
  value = aws_apigatewayv2_domain_name.api-sawyerbrink.arn
}

output "main-api-mapping" {
  value = aws_apigatewayv2_api_mapping.api-sawyerbrink-mapping.id
}

output "api-target-domain" {
  value = aws_apigatewayv2_domain_name.api-sawyerbrink.domain_name_configuration.0.target_domain_name
}

output "api-gateway-authorizer-id" {
  value = module.apigateway-core.main-api-authorizer-id
}
###################################
# S3
####################################
output "customer-documents-bucket-id" {
  value = aws_s3_bucket.customers-documents.id
}

# output "raw-data-bucket-id" {
#   value = aws_s3_bucket.raw-data-storage.id
# }

# output "raw-data-bucket-arn" {
#   value = aws_s3_bucket.raw-data-storage.arn
# }

output "logging-bucket-id" {
  value = aws_s3_bucket.logging-storage.id
}
#####################################
# IAM Roles
#######################################
output "main-lambda-role-arn" {
  value = aws_iam_role.lambda-role.arn
}

output "apigateway-s3-role-arn" {
  value = aws_iam_role.lambda-apigateway-role-s3.arn
}

output "lambda-sqs-role-arn" {
  value = aws_iam_role.lambda-sqs-role.arn
}

output "lambda-s3-role-arn" {
  value = aws_iam_role.lambda-role-s3.arn
}

output "apigateway-delete-role-arn" {
  value = aws_iam_role.lambda-role-delete.arn
}

output "apigateway-presigned-role-arn" {
  value = aws_iam_role.lambda-apigateway-role-presigned-url.arn
}

output "lambda-index-documents-role-arn" {
  value = aws_iam_role.index-document-lambda.arn
}

output "cloudwatch-cron-role" {
  value = aws_iam_role.cloudwatch-cron-log-role.arn
}

output "lambda-batch-trigger-role-arn" {
  value = aws_iam_role.lambda-batch-trigger-role.arn
}

output "lambda-rds-role-arn" {
  value = aws_iam_role.lambda-rds-role.arn
}

###########################################
# SQS
############################################
output "audit-sqs-url" {
  value = aws_sqs_queue.audit-queue.id
}

output "audit-sqs-arn" {
  value = aws_sqs_queue.audit-queue.arn
}

output "customer-sqs-url" {
  value = aws_sqs_queue.deadletter-customer-documents-queue.id
}

output "customer-sqs-arn" {
  value = aws_sqs_queue.customer-documents-queue.arn
}
############################################
# AWS Batch
#############################################
output "batch-compute-environment-arn" {
  value = aws_batch_compute_environment.batch-compute-environment.arn
}

output "batch-compute-environment-ecs-cluster-arn" {
  value = aws_batch_compute_environment.batch-compute-environment.ecs_cluster_arn
}

output "batch-compute-queue-arn" {
  value = aws_batch_job_queue.batch-compute-queue.arn
}

output "batch-compute-environment-job-definition-arn" {
  value = aws_batch_job_definition.batch-compute-job-definition.arn
}
############################################
# AWS Aurora DB
############################################

output "aurora-db-arn" {
  value = aws_rds_cluster.postgresql-rds.arn
}

output "aurora-db-id" {
  value = aws_rds_cluster.postgresql-rds.id
}

output "aurora-db-endpoint" {
  value = aws_rds_cluster.postgresql-rds.endpoint
}

output "aurora-db-identifier" {
  value = aws_rds_cluster.postgresql-rds.cluster_identifier
}

output "aurora-db-cluster-resource-id" {
  value = aws_rds_cluster.postgresql-rds.cluster_resource_id
}

output "aurora-db-reader-endpoint" {
  value = aws_rds_cluster.postgresql-rds.reader_endpoint
}

output "aurora-db-reader-r53-hosted-zone" {
  value = aws_rds_cluster.postgresql-rds.hosted_zone_id
}

output "cluster-identifier" {
  value = aws_rds_cluster.postgresql-rds.cluster_identifier
}

output "aurora-db-custom-reader-endpoint" {
  value = aws_rds_cluster_endpoint.static-write.endpoint
}

output "aurora-db-custom-writer-endpoint" {
  value = try(aws_rds_cluster_endpoint.static-read[0].endpoint, aws_rds_cluster.postgresql-rds.endpoint)
}