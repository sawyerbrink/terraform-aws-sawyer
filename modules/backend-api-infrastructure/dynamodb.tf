#############################
# DynomoDB
#############################
resource "aws_dynamodb_table" "organization-table" {
  count = var.dynamodb-billing-mode == "PAY_PER_REQUEST" ? 1 : 0
  name         = "${var.name}-main"
  billing_mode = var.dynamodb-billing-mode
  hash_key  = "pk"
  range_key = "sk"

  stream_enabled = var.dynamodb-stream

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  attribute {
    name = "type"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms-key-arn
  }

  global_secondary_index {
    name            = "gsi-1"
    hash_key        = "type"
    range_key       = "sk"
    write_capacity  = var.dynamodb-gsi-provisioning-write-capacity
    read_capacity   = var.dynamodb-gsi-provisioning-read-capacity
    projection_type = "ALL"
  }

  point_in_time_recovery {
    enabled = var.dynamodb-point-in-recovery
  }

  tags = merge({ Name = "${var.name}-table-${var.environment}-${var.region}" }, var.tags)

}

resource "aws_dynamodb_table" "organization-table-" {
  count = var.dynamodb-billing-mode == "PROVISIONED" ? 1 : 0
  name         = "${var.name}-main"
  billing_mode = var.dynamodb-billing-mode
  read_capacity  = var.dynamodb-provisioning-read-capacity
  write_capacity = var.dynamodb-provisioning-write-capacity
  hash_key  = "pk"
  range_key = "sk"

  stream_enabled = var.dynamodb-stream

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  attribute {
    name = "type"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms-key-arn
  }

  global_secondary_index {
    name            = "gsi-1"
    hash_key        = "type"
    range_key       = "sk"
    write_capacity  = var.dynamodb-gsi-provisioning-write-capacity
    read_capacity   = var.dynamodb-gsi-provisioning-read-capacity
    projection_type = "ALL"
  }

  point_in_time_recovery {
    enabled = var.dynamodb-point-in-recovery
  }

  tags = merge({ Name = "${var.name}-table-${var.environment}-${var.region}" }, var.tags)

}