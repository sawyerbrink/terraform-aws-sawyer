resource "aws_s3_bucket" "code-storage" {
  bucket        = "${lower(var.name)}-ui-code-${var.environment}-${var.region}"
  acl           = "private"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        // MUST use AES256 in order to leverage Cloudfront
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    max_age_seconds = 1500
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = merge({ data-classification = "Confidential" }, {})

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 2

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "ONEZONE_IA"
    }

    expiration {
      days = 457
    }
  }

  lifecycle {
    ignore_changes = [replication_configuration]
  }
}

#############################
# DR Bucket
##############################
resource "aws_s3_bucket" "code-storage-DR" {
  provider      = aws.dr
  bucket        = "${lower(var.name)}-ui-code-${var.environment}-${var.dr-region}"
  acl           = "private"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        // MUST use AES256 in order to leverage Cloudfront
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    max_age_seconds = 1500
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }


  tags = merge({ data-classification = "Confidential" }, {})

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 2

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "ONEZONE_IA"
    }

    expiration {
      days = 457
    }
  }

  depends_on = [aws_s3_bucket.code-storage]
}
#############################
# Cross Region Replication
#############################
#############################
# Execut AWS CLI script
#############################
resource "local_file" "s3-replication-config" {
  content         = <<EOT
  {
    "Role": "${aws_iam_role.s3-replication.arn}",
    "Rules": [
        {
            "Status": "Enabled",
             "SourceSelectionCriteria": {
                "SseKmsEncryptedObjects": {
                  "Status": "Enabled"
                }
             },
            "Priority": 1,
            "DeleteMarkerReplication": { "Status": "Enabled" },
            "Filter" : { "Prefix": ""},
            "Destination": {
                "Bucket": "${aws_s3_bucket.code-storage-DR.arn}",
                "EncryptionConfiguration": {
                  "ReplicaKmsKeyID": "arn:aws:kms:${var.dr-region}:${var.account_id}:alias/aws/s3"
                 },
                "StorageClass": "STANDARD",
                "Account": "${var.account_id}"
              }
        }
    ]
}
EOT
  filename        = "${path.module}/replication-config.json"
  file_permission = "0755"
}

resource "null_resource" "enable-crr" {
  count = var.profile == "" ? 1 : 0
  triggers = {
    id = aws_s3_bucket.code-storage-DR.arn
  }

  provisioner "local-exec" {
    command = <<EOT
      aws s3api put-bucket-replication --bucket ${aws_s3_bucket.code-storage.id} --replication-configuration file://${local_file.s3-replication-config.filename}
    EOT
  }
  depends_on = [local_file.s3-replication-config, aws_s3_bucket.code-storage, aws_s3_bucket.code-storage-DR]
}

resource "null_resource" "enable-crr-profile" {
  count = var.profile != "" ? 1 : 0
  triggers = {
    id = aws_s3_bucket.code-storage-DR.arn
  }

  provisioner "local-exec" {
    command = <<EOT
      aws s3api put-bucket-replication --profile ${var.profile} --bucket ${aws_s3_bucket.code-storage.id} --replication-configuration file://${local_file.s3-replication-config.filename}
    EOT
  }
  depends_on = [local_file.s3-replication-config, aws_s3_bucket.code-storage, aws_s3_bucket.code-storage-DR]
}

