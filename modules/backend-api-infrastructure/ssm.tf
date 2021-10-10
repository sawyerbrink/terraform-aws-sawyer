resource "aws_ssm_parameter" "rds-master-password" {
  name        = "${var.name}-master-db-password"
  description = "The Saywer master database name."
  type        = "SecureString"
  value       = var.rds-db-master-password
}