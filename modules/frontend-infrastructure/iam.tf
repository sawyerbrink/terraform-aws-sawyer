resource "aws_iam_role" "s3-replication" {
  name               = "sawyerbrink-s3-replication"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "role-permissions" {
  role   = aws_iam_role.s3-replication.name
  name   = "Replication-Permissions"
  policy = data.aws_iam_policy_document.iam-permissions.json
}


data "aws_iam_policy_document" "iam-permissions" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags"
    ]
    resources = [
      "${aws_s3_bucket.code-storage-DR.arn}/*",
      "${aws_s3_bucket.code-storage-DR.arn}/*"
    ]

  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl"
    ]
    resources = [
      aws_s3_bucket.code-storage.arn,
      "${aws_s3_bucket.code-storage.arn}/*",
      aws_s3_bucket.code-storage-DR.arn,
      "${aws_s3_bucket.code-storage-DR.arn}/*"
    ]

  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.code-storage.arn,
      aws_s3_bucket.code-storage-DR.arn
    ]
  }
}

resource "aws_iam_role" "lambda-website-build-role" {
  name = "saywer-lambda-website-build-role"

  assume_role_policy = data.aws_iam_policy_document.lambda-website-assume-role-policy.json

  inline_policy {
    name   = "default-permissions"
    policy = data.aws_iam_policy_document.lambda-website-permissions-policy.json
  }
}

data "aws_iam_policy_document" "lambda-website-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda-website-permissions-policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions",
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
      "s3:GetBucketLocation",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
    ]
    resources = [
      aws_s3_bucket.code-storage.arn,
      "${aws_s3_bucket.code-storage.arn}/*",
      aws_s3_bucket.code-storage-DR.arn,
      "${aws_s3_bucket.code-storage-DR.arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketVersioning",
      "s3:GetBucketTagging",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = [
      "arn:aws:s3:::${local.website-assets-source-bucket}",
      "arn:aws:s3:::${local.website-assets-source-bucket}/*"
    ]
  }
}