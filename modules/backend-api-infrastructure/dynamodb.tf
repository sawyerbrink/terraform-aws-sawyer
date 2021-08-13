#############################
# DynomoDB
#############################
resource "aws_dynamodb_table" "organization-table" {
  name         = "Organization"
  billing_mode = "PAY_PER_REQUEST"
  # read_capacity  = 6
  # write_capacity = 10
  hash_key  = "pk"
  range_key = "sk"

  stream_enabled = false

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
    kms_key_arn = data.aws_kms_key.main-key-alias.arn
  }

  global_secondary_index {
    name            = "gsi-1"
    hash_key        = "type"
    range_key       = "sk"
    write_capacity  = 4
    read_capacity   = 10
    projection_type = "ALL"
  }

  point_in_time_recovery {
    enabled = var.environment == "prod" ? true : false
  }

  tags = merge({ Name = "dynamodb-table-${var.environment}-${var.region}" }, var.tags)

}