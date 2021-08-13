resource "aws_s3_bucket" "logging-storage" {
  bucket        = "sawyerbrink-audit-logging-${var.environment}"
  acl           = "private"
  force_destroy = var.environment == "test" ? true : false

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_key.main-key-alias.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = merge({ data-classification = "Confidential" }, var.tags)

  versioning {
    enabled = false
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

    transition {
      days          = 365
      storage_class = "GLACIER"
    }

    expiration {
      days = 457
    }


  }
}

resource "aws_s3_bucket_policy" "logging-storage-bucket-policy" {
  bucket = aws_s3_bucket.logging-storage.id

  policy = <<POLICY
{
  "Id": "Policy1602974231825",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1602974000867",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.logging-storage.arn}",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/administrator"
        ]
      }
    },
    {
      "Sid": "Stmt1602974227141",
      "Action": [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectRetention",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketVersioning",
      "s3:GetBucketTagging",
      "s3:GetBucketLocation"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.logging-storage.arn}",
        "${aws_s3_bucket.logging-storage.arn}/*"
      ],
      "Principal": {
        "AWS": [
          "${aws_iam_role.lambda-sqs-role.arn}"
        ]
      }
    }
  ]
}  
POLICY

  depends_on = [aws_iam_role.lambda-sqs-role]
}

resource "aws_s3_bucket_ownership_controls" "logging-storage-bucket-ownership" {
  bucket = aws_s3_bucket.logging-storage.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_object" "object" {
  count  = var.environment == "test" ? 1 : 0
  bucket = aws_s3_bucket.logging-storage.id
  key    = "o3601061207202066ef3f44/2000/01/04/summary.json"
  source = "../../../static/summary.json"

  depends_on = [
	aws_s3_bucket_ownership_controls.logging-storage-bucket-ownership,
  ]
}

resource "aws_s3_bucket" "customers-documents" {
  bucket        = "sawyerbrink-customers-documents-${var.environment}"
  acl           = "private"
  force_destroy = var.environment == "test" ? true : false

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_key.main-key-alias.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET", "HEAD", "DELETE"]
    max_age_seconds = 1500
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }

  tags = merge({ data-classification = "Confidential" }, var.tags)

  versioning {
    enabled = false
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

    transition {
      days          = 365
      storage_class = "GLACIER"
    }

    expiration {
      days = 457
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "customer-documents-bucket-ownership" {
  bucket = aws_s3_bucket.customers-documents.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [aws_s3_bucket.customers-documents]
}

resource "aws_s3_bucket_notification" "customer-documents-bucket-notification" {
  bucket = aws_s3_bucket.customers-documents.id

  queue {
    queue_arn = aws_sqs_queue.customer-documents-queue.arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_s3_bucket.customers-documents, aws_sqs_queue.customer-documents-queue]
}


resource "aws_s3_bucket_policy" "customer-documents-bucket-policy" {
  bucket = aws_s3_bucket.customers-documents.id

  policy     = <<POLICY
{
  "Id": "Policy1602974231828",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1602974000867",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.customers-documents.arn}",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/administrator"
        ]
      }
    },
    {
      "Sid": "Stmt1602974227141",
      "Action": [
        "s3:GetBucketAcl",
        "s3:GetBucketCORS",
        "s3:GetBucketLocation",
        "s3:GetBucketPublicAccessBlock",
        "s3:GetBucketVersioning",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl",
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:PutObjectTagging",
        "s3:PutObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.customers-documents.arn}",
        "${aws_s3_bucket.customers-documents.arn}/*"
      ],
      "Principal": {
        "AWS": [
          "${aws_iam_role.lambda-apigateway-role-presigned-url.arn}"
        ]
      }
    }
  ]
}
POLICY
  depends_on = [aws_iam_role.lambda-apigateway-role-presigned-url, aws_s3_bucket.customers-documents]
}
#################################
# Raw Data Storage
###############################
# resource "aws_s3_bucket" "raw-data-storage" {
#   bucket        = "sawyerbrink-raw-data-${var.environment}-${var.region}"
#   acl           = "private"
#   force_destroy = var.environment == "test" ? true : false

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         kms_master_key_id = data.aws_kms_key.main-key-alias.arn
#         sse_algorithm     = "aws:kms"
#       }
#     }
#   }

#   tags = merge({ data-classification = "Confidential" }, var.tags)

#   versioning {
#     enabled = false
#   }

#   lifecycle_rule {
#     enabled                                = true
#     abort_incomplete_multipart_upload_days = 2

#     transition {
#       days          = 30
#       storage_class = "STANDARD_IA"
#     }

#     transition {
#       days          = 60
#       storage_class = "ONEZONE_IA"
#     }

#     transition {
#       days          = 365
#       storage_class = "GLACIER"
#     }

#     expiration {
#       days = 457
#     }
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "raw-data-storage-bucket-ownership" {
#   bucket = aws_s3_bucket.raw-data-storage.id

#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }

#   depends_on = [aws_s3_bucket.raw-data-storage]
# }

# // S3 Notification Event configured in the backend-api-functions project

# resource "aws_s3_bucket_policy" "raw-data-storage-bucket-bucket-policy" {
#   bucket = aws_s3_bucket.raw-data-storage.id

#   policy     = <<POLICY
# {
#   "Id": "Policy1602974231828",
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "Stmt1602974000867",
#       "Action": "s3:*",
#       "Effect": "Allow",
#       "Resource": "${aws_s3_bucket.raw-data-storage.arn}",
#       "Principal": {
#         "AWS": [
#           "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/administrator"
#         ]
#       }
#     },
#     {
#       "Sid": "Stmt1602974227141",
#       "Action": [
#         "s3:GetBucketAcl",
#         "s3:GetBucketCORS",
#         "s3:GetBucketLocation",
#         "s3:GetBucketPublicAccessBlock",
#         "s3:GetBucketVersioning",
#         "s3:GetObject",
#         "s3:GetObjectAcl",
#         "s3:GetObjectVersion",
#         "s3:GetObjectVersionAcl",
#         "s3:ListBucket",
#         "s3:ListBucketVersions",
#         "s3:PutObject",
#         "s3:PutObjectAcl",
#         "s3:PutObjectTagging",
#         "s3:PutObjectVersionTagging"
#       ],
#       "Effect": "Allow",
#       "Resource": [
#         "${aws_s3_bucket.raw-data-storage.arn}",
#         "${aws_s3_bucket.raw-data-storage.arn}/*"
#       ],
#       "Principal": {
#         "AWS": [
#           "${aws_iam_role.data-pipeline-ec2-role.arn}"
#         ]
#       }
#     }
#   ]
# }
# POLICY
#   depends_on = [aws_iam_role.data-pipeline-ec2-role, aws_s3_bucket.raw-data-storage]
# }

