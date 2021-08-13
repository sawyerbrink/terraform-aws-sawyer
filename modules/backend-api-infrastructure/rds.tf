resource "aws_rds_cluster" "postgresql-rds" {
  cluster_identifier = "sawyerbrink-${var.environment}-${var.region}-relational-db"
  availability_zones = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2],
  ]
  database_name = var.rds-db-name

  master_username                     = "postgres"
  master_password                     = data.aws_ssm_parameter.db-password.value
  iam_database_authentication_enabled = true

  backup_retention_period   = 1
  final_snapshot_identifier = "sawyerbrink-${var.environment}-${var.region}-relational-db-finalsnapshot"
  apply_immediately         = var.environment == "prod" ? false : true
  deletion_protection       = var.environment == "prod" ? true : false
  skip_final_snapshot       = var.environment == "prod" ? false : true

  copy_tags_to_snapshot = true

  engine_mode    = "provisioned"
  engine         = var.rds-postgres-engine
  engine_version = var.rds-postgres-engine-version
  port           = var.rds-db-port

  vpc_security_group_ids = data.aws_security_groups.sb-list.ids

  storage_encrypted = true
  kms_key_id        = data.aws_kms_key.main-key-alias.arn

  preferred_maintenance_window    = "Fri:23:00-Sat:02:00"
  preferred_backup_window         = "02:15-03:00"
  enabled_cloudwatch_logs_exports = toset(["postgresql"])



  lifecycle {
    ignore_changes = [availability_zones]
  }
}


resource "aws_rds_cluster_instance" "main-cluster-instances" {
  count                 = var.environment == "prod" ? 2 : 1
  identifier            = "aurora-cluster-sawyer-${count.index}"
  cluster_identifier    = aws_rds_cluster.postgresql-rds.id
  instance_class        = "db.t3.medium"
  engine                = aws_rds_cluster.postgresql-rds.engine
  engine_version        = aws_rds_cluster.postgresql-rds.engine_version
  apply_immediately     = var.environment == "prod" ? false : true
  publicly_accessible   = var.environment == "prod" ? false : true
  copy_tags_to_snapshot = true

  preferred_maintenance_window = "Fri:23:00-Sat:02:00"
  auto_minor_version_upgrade   = false
  tags                         = var.tags
}

resource "aws_rds_cluster_endpoint" "static-write" {
  cluster_identifier          = aws_rds_cluster.postgresql-rds.id
  cluster_endpoint_identifier = "reader"
  custom_endpoint_type        = "ANY"
  tags                        = merge({ "Name" = "static-WRITE-endpoint" }, var.tags)
  static_members = [
    aws_rds_cluster_instance.main-cluster-instances[0].id
  ]
}

resource "aws_rds_cluster_endpoint" "static-read" {
  count                       = var.environment == "prod" ? 1 : 0
  cluster_identifier          = aws_rds_cluster.postgresql-rds.id
  cluster_endpoint_identifier = "writer"
  custom_endpoint_type        = "READER"
  tags                        = merge({ "Name" = "static-READ-endpoint" }, var.tags)
  excluded_members = [
    aws_rds_cluster_instance.main-cluster-instances[0].id
  ]
}

resource "aws_db_subnet_group" "default" {
  name        = "default-${var.environment}-db-subnets"
  subnet_ids  = data.aws_subnet_ids.sb-vpc.ids
  description = "Managed by Terraform"


}

resource "aws_cloudwatch_log_group" "rds-logs" {
  name              = "/aws/rds/sawyerbrink-${var.environment}-${var.region}-relational-db/postgresql"
  retention_in_days = 1
  tags              = var.tags
  kms_key_id        = data.aws_kms_key.main-key-alias.arn
}

############################
# Execut CLI script
############################
resource "null_resource" "init-rds" {

  triggers = {
    id = aws_rds_cluster.postgresql-rds.arn
  }

  provisioner "local-exec" {
    command = <<EOT
      aws lambda invoke --function-name setup_db --region ${var.region} response.json
    EOT
  }
  depends_on = [aws_rds_cluster.postgresql-rds, aws_rds_cluster_instance.main-cluster-instances, aws_lambda_function.setupDB]
}

###########################
# Monitoring
###########################
resource "aws_db_event_subscription" "default" {
  count     = var.environment == "prod" ? 1 : 0
  name      = "rds-event-subscription"
  sns_topic = data.aws_sns_topic.sawyerbrink-support.arn

  source_type = "db-instance"
  source_ids  = toset(aws_rds_cluster_instance.main-cluster-instances[*].id)

  event_categories = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica"
  ]

  tags = var.tags
}