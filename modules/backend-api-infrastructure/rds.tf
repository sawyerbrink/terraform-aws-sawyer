resource "aws_rds_cluster" "postgresql-rds" {
  cluster_identifier = "sawyerbrink-${var.environment}-${var.region}-relational-db"
  availability_zones = length(var.rds-az-list) > 0 ? var.rds-az-list : slice(data.aws_availability_zones.available.names,0, 2)
  
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

  vpc_security_group_ids = var.security-group-ids

  storage_encrypted = true
  kms_key_id        = local.default-kms-policy

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
  instance_class        = var.rds-instance-size
  engine                = aws_rds_cluster.postgresql-rds.engine
  engine_version        = aws_rds_cluster.postgresql-rds.engine_version
  apply_immediately     = var.environment == "prod" ? false : true
  publicly_accessible   = var.environment == "prod" ? false : true
  copy_tags_to_snapshot = true

  preferred_maintenance_window = "Fri:23:00-Sat:02:00"
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

resource "aws_db_subnet_group" "default" {
  name        = "default-${var.environment}-db-subnets"
  subnet_ids  = data.aws_subnet_ids.sb-vpc.ids
  description = "Managed by Terraform"


}

resource "aws_cloudwatch_log_group" "rds-logs" {
  name              = "/aws/rds/sawyerbrink-${var.environment}-${var.region}-relational-db/postgresql"
  retention_in_days = 1
  kms_key_id        = local.default-kms-policy
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