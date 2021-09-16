module "backend-api-infrastructure" {
  source = "./modules/backend-api-infrastructure"

  sawyer-version           = var.sawyer-version
  org-id                   = data.null_data_source.values.outputs["org_id"]
  profile                  = var.profile
  region                   = var.region
  tags                     = var.tags
  logs-retention           = var.logs-retention
  name                     = var.name
  kms-key-arn              = var.kms-key-arn
  lambda-repository-region = var.lambda-repository-region
  newslit-api-key          = var.newslit-api-key

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

  lambda-sqs-index-document-concurrency-limit = var.backendinfra-lambda-sqs-index-document-concurrency-limit
  lambda-sqs-logging-concurrency-limit        = var.backendinfra-lambda-sqs-logging-concurrency-limit
  # Batch
  risk-sensing-image-version                  = var.backendinfra-risk-sensing-image-version
  batch-cpu                                   = var.backendinfra-batch-cpu
  batch-memory                                = var.backendinfra-batch-memory
  fargate-version                             = var.backendinfra-fargate-version
  batch-state          = var.backendinfra-batch-state
  batch-type           = var.backendinfra-batch-type
  batch-max-cpus       = var.backendinfra-batch-max-cpus
  batch-compute-type   = var.backendinfra-batch-compute-type
  batch-retry-attempts = var.backendinfra-batch-retry-attempts
  # RDS
  rds-db-master-password                      = local.db-master-password
  rds-instance-size                           = var.backendinfra-rds-instance-size
  rds-instances                               = var.backendinfra-rds-instances
  rds-apply-immediately                       = var.backendinfra-rds-apply-immediately
  rds-enable-public-ip                        = var.backendinfra-rds-enable-public-ip
  rds-maintenance-window                      = var.backendinfra-rds-maintenance-window
  rds-preferred-backup-window                 = var.backendinfra-rds-preferred-backup-window
  rds-backup-retention-period                 = var.backendinfra-rds-backup-retention-period
  rds-delete-protection                       = var.backendinfra-rds-delete-protection
  rds-read-role                               = var.backendinfra-rds-read-role
  rds-write-role                              = var.backendinfra-rds-write-role
  rds-db-name                                 = var.backendinfra-rds-db-name
  rds-db-port                                 = var.backendinfra-rds-db-port
  rds-postgres-engine-version                 = var.backendinfra-rds-postgres-engine-version
  rds-postgres-engine                         = var.backendinfra-rds-postgres-engine
  rds-az-list                                 = var.backendinfra-rds-az-list
  rds-db-subnet-name                          = var.backendinfra-rds-db-subnet-name

  ses-email-arn = var.ses-email-arn
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
