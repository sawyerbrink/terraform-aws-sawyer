module "backend-api-infrastructure" {
  source = "./modules/backend-api-infrastructure"

  sawyer-version           = var.sawyer-version
  org-id                   = local.orgId
  org-name                 = var.org-name
  org-email-domain         = var.org-email-domain
  org-industry             = var.org-industry
  org-size                 = var.org-size
  profile                  = var.profile
  region                   = var.region
  tags                     = var.tags
  logs-retention           = var.logs-retention
  name                     = var.name
  kms-key-arn              = var.kms-key-arn
  lambda-repository-region = var.lambda-repository-region

  support-sns-topic                           = var.backendinfra-support-sns-topic
  api-name                                    = var.backendinfra-api-name
  api-description                             = var.backendinfra-api-description
  disable-default-endpoint                    = var.backendinfra-disable-default-endpoint
  authorizer-type                             = var.backendinfra-authorizer-type
  environment                                 = var.backendinfra-environment
  api-version                                 = var.backendinfra-api-version
  api-stage-name                              = var.backendinfra-api-stage-name
  protocol-type                               = var.backendinfra-protocol-type
  api-stage-auto-deploy                       = var.backendinfra-api-stage-auto-deploy
  security-policy                             = var.backendinfra-security-policy
  passthrough-behavior                        = var.backendinfra-passthrough-behavior
  tracing-mode                                = var.backendinfra-tracing-mode
  route-timeout                               = var.backendinfra-route-timeout
  access-log-format                           = var.backendinfra-access-log-format
  cors-allow-origins                          = var.backendinfra-cors-allow-origins
  cors-allow-headers                          = var.backendinfra-cors-allow-headers
  cors-allow-methods                          = var.backendinfra-cors-allow-methods
  cors-expose-headers                         = var.backendinfra-cors-expose-headers
  s3-force-destroy                            = var.backendinfra-s3-force-destroy
  domain-name                                 = var.backendinfra-domain-name
  api-domain-name                             = var.backendinfra-api-domain-name
  auth-domain                                 = var.backendinfra-auth-domain
  newslit-api-key                             = var.newslit-api-key
  lambda-sqs-index-document-concurrency-limit = var.backendinfra-lambda-sqs-index-document-concurrency-limit
  lambda-sqs-logging-concurrency-limit        = var.backendinfra-lambda-sqs-logging-concurrency-limit
  # Batch
  risk-sensing-image-version = var.backendinfra-risk-sensing-image-version
  batch-cpu                  = var.backendinfra-batch-cpu
  batch-memory               = var.backendinfra-batch-memory
  fargate-version            = var.backendinfra-fargate-version
  batch-state                = var.backendinfra-batch-state
  batch-type                 = var.backendinfra-batch-type
  batch-max-cpus             = var.backendinfra-batch-max-cpus
  batch-compute-type         = var.backendinfra-batch-compute-type
  batch-retry-attempts       = var.backendinfra-batch-retry-attempts
  # RDS
  rds-db-master-password      = local.db-master-password
  rds-instance-size           = var.backendinfra-rds-instance-size
  rds-instances               = var.backendinfra-rds-instances
  rds-apply-immediately       = var.backendinfra-rds-apply-immediately
  rds-enable-public-ip        = var.backendinfra-rds-enable-public-ip
  rds-maintenance-window      = var.backendinfra-rds-maintenance-window
  rds-preferred-backup-window = var.backendinfra-rds-preferred-backup-window
  rds-backup-retention-period = var.backendinfra-rds-backup-retention-period
  rds-delete-protection       = var.backendinfra-rds-delete-protection
  rds-read-role               = var.backendinfra-rds-read-role
  rds-write-role              = var.backendinfra-rds-write-role
  rds-db-name                 = var.backendinfra-rds-db-name
  rds-db-port                 = var.backendinfra-rds-db-port
  rds-postgres-engine-version = var.backendinfra-rds-postgres-engine-version
  rds-postgres-engine         = var.backendinfra-rds-postgres-engine
  rds-az-list                 = var.backendinfra-rds-az-list
  rds-db-subnet-name          = var.backendinfra-rds-db-subnet-name
  # Cognito
  mfa_configuration = var.backendinfra-mfa-configuration

  ses-email-arn       = var.ses-email-arn
  api-certificate-arn = var.backendinfra-api-certificate-arn


  vpc-id         = var.backendinfra-vpc-id
  db-subnets-ids = var.backendinfra-db-subnets-ids



  dynamodb-billing-mode                    = var.backendinfra-dynamodb-billing-mode
  dynamodb-provisioning-read-capacity      = var.backendinfra-dynamodb-provisioning-read-capacity
  dynamodb-provisioning-write-capacity     = var.backendinfra-dynamodb-provisioning-write-capacity
  dynamodb-point-in-recovery               = var.backendinfra-dynamodb-point-in-recovery
  dynamodb-stream                          = var.backendinfra-dynamodb-stream
  dynamodb-gsi-provisioning-read-capacity  = var.backendinfra-dynamodb-gsi-provisioning-read-capacity
  dynamodb-gsi-provisioning-write-capacity = var.backendinfra-dynamodb-gsi-provisioning-write-capacity

  private-subnet-ids   = var.backendinfra-private-subnet-ids
  security-group-ids   = var.backendinfra-security-group-ids
  iam-kms-grant-policy = var.backendinfra-iam-kms-grant-policy
}


module "backend-api-functions" {
  source = "./modules/backend-api-functions"
  ## Environment
  region         = var.region
  kms-key-arn    = var.kms-key-arn
  environment    = var.backendinfra-environment
  sawyer-version = var.sawyer-version

  ## API
  api-description   = var.backendinfra-api-description
  api-version       = var.backendinfra-api-version
  api-id            = module.backend-api-infrastructure.main-api-id
  api-execution-arn = module.backend-api-infrastructure.main-api-execution-arn
  api-stage-id      = module.backend-api-infrastructure.main-api-stage-id
  authorizer-id     = module.backend-api-infrastructure.api-gateway-authorizer-id
  ## DynamoDB
  dynamodb-table-id = module.backend-api-infrastructure.organization-table-id
  ## SQS
  audit-sqs-url                = module.backend-api-infrastructure.audit-sqs-url
  lambda-sqs-role-arn          = module.backend-api-infrastructure.lambda-sqs-role-arn
  customer-documents-sqs-url   = module.backend-api-infrastructure.customer-sqs-url
  customer-documents-queue-arn = module.backend-api-infrastructure.customer-sqs-arn
  audits-queue-arn             = module.backend-api-infrastructure.audit-sqs-arn
  ## RDS
  rds-reader-endpoint = module.backend-api-infrastructure.aurora-db-reader-endpoint
  ## Lambda
  lambda-repository-region        = var.lambda-repository-region
  main-lambda-role-arn            = module.backend-api-infrastructure.main-lambda-role-arn
  lambda-security-groups-ids      = var.backendinfra-lambda-security-groups-ids
  lambda-subnet-ids               = var.backendinfra-lambda-subnet-ids
  lambda-delete-audits-role-arn   = module.backend-api-infrastructure.apigateway-delete-role-arn
  lambda-presigned_url-role-arn   = module.backend-api-infrastructure.apigateway-presigned-role-arn
  lambda-index-documents-role-arn = module.backend-api-infrastructure.lambda-index-documents-role-arn
  # S3
  apigateway-s3-role-arn    = module.backend-api-infrastructure.apigateway-s3-role-arn
  lambda-s3-role-arn        = module.backend-api-infrastructure.lambda-s3-role-arn
  audit-logging-bucket      = module.backend-api-infrastructure.logging-bucket-id
  customer-documents-bucket = module.backend-api-infrastructure.customer-documents-bucket-id
  ## Batch
  lambda-batch-trigger-role-arn = module.backend-api-infrastructure.lambda-batch-trigger-role-arn
  batch-compute-queue-arn       = module.backend-api-infrastructure.batch-compute-queue-arn
  batch-job-definition-arn      = module.backend-api-infrastructure.batch-compute-environment-job-definition-arn
  ## Logging
  enable-audit-logging        = var.backendinfra-enable-audit-logging
  sns-topic-arn               = var.backendinfra-support-sns-topic
  cloudwatch-trigger-role-arn = module.backend-api-infrastructure.cloudwatch-cron-role
  ## Newslit API
  newslit-api-key = var.newslit-api-key


  depends_on = [
    module.backend-api-infrastructure
  ]
}


module "frontend-infrastructure" {
  source = "./modules/frontend-infrastructure"

  profile                          = var.profile
  sawyer-version                   = var.sawyer-version
  website-repository-region        = var.website-repository-region
  name                             = var.name
  domain                           = var.backendinfra-domain-name
  region                           = var.region
  dr-region                        = var.dr-region
  environment                      = var.backendinfra-environment
  kms-key-arn                      = var.kms-key-arn
  website-build-lambda-memory-size = var.website-build-lambda-memory-size
  min-tls-version                  = var.frontendinfra-min-tls-version
  api-version                      = var.backendinfra-api-version

  cognito-userpool-id        = module.backend-api-infrastructure.user-pool-id
  cognito-userpool-client-id = module.backend-api-infrastructure.implicit-client-id
  logs-retention             = var.logs-retention
  account_id                 = local.account_id

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }

  depends_on = [
    module.backend-api-infrastructure,
    module.backend-api-functions
  ]

}