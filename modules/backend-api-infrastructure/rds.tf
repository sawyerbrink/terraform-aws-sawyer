resource "aws_rds_cluster" "postgresql-rds" {
  cluster_identifier = "sawyerbrink-${var.environment}-${var.region}-relational-db"
  availability_zones = var.rds-az-list
  
  database_name = var.rds-db-name


  master_username                     = "postgres"
  master_password                     = var.rds-db-master-password
  iam_database_authentication_enabled = true

  backup_retention_period   = var.rds-backup-retention-period
  final_snapshot_identifier = "sawyerbrink-${var.environment}-${var.region}-relational-db-finalsnapshot"
  apply_immediately         = var.rds-apply-immediately
  deletion_protection       = var.rds-delete-protection
  skip_final_snapshot       = true

  copy_tags_to_snapshot = true

  engine_mode    = "provisioned"
  engine         = var.rds-postgres-engine
  engine_version = var.rds-postgres-engine-version
  port           = var.rds-db-port

  vpc_security_group_ids = var.security-group-ids
  db_subnet_group_name   = var.rds-db-subnet-name

  storage_encrypted = true
  kms_key_id        = var.kms-key-arn

  preferred_maintenance_window    = var.rds-maintenance-window
  preferred_backup_window         = var.rds-preferred-backup-window
  enabled_cloudwatch_logs_exports = toset(["postgresql"])



  lifecycle {
    ignore_changes = [availability_zones]
  }
}


resource "aws_rds_cluster_instance" "main-cluster-instances" {
  count                 = var.rds-instances
  identifier            = "aurora-cluster-sawyer-${count.index}"
  cluster_identifier    = aws_rds_cluster.postgresql-rds.id
  instance_class        = var.rds-instance-size
  engine                = aws_rds_cluster.postgresql-rds.engine
  engine_version        = aws_rds_cluster.postgresql-rds.engine_version
  apply_immediately     = var.rds-apply-immediately
  publicly_accessible   = var.rds-enable-public-ip
  copy_tags_to_snapshot = true
  db_subnet_group_name   = var.rds-db-subnet-name

  preferred_maintenance_window = var.rds-maintenance-window
  auto_minor_version_upgrade   = false
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

# resource "aws_db_subnet_group" "default" {
#   name        = "sawyer-${var.environment}-db-subnets"
#   subnet_ids  = var.db-subnets-ids
#   description = "Managed by Terraform"
# }

resource "aws_cloudwatch_log_group" "rds-logs" {
  name              = "/aws/rds/sawyerbrink-${var.environment}-${var.region}-relational-db/postgresql"
  retention_in_days = var.logs-retention
  kms_key_id        = var.kms-key-arn
}

############################
# Execut CLI script
############################
resource "null_resource" "init-rds-with-profile" {

  count = var.profile != "" ? 1 : 0

  triggers = {
    id = aws_rds_cluster.postgresql-rds.arn
  }

  provisioner "local-exec" {
    command = <<EOT
      aws lambda invoke --function-name setup_db --region ${var.region} response.json --profile ${var.profile}
    EOT
  }
  depends_on = [aws_rds_cluster.postgresql-rds, aws_rds_cluster_instance.main-cluster-instances, aws_lambda_function.setupDB]
}

resource "null_resource" "init-rds" {

  count = var.profile == "" ? 1 : 0

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