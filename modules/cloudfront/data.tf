data "aws_iam_policy_document" "sb-s3-spa-dr-policy-document" {
  provider = aws.dr
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.access-origin-dr.iam_arn]
    }

    sid     = "OnlyCloudFrontReadAccess"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      var.bucket-dr-arn,
      "${var.bucket-dr-arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:role/administrator"]
    }

    sid     = "AllowSayerBrinkAdmins"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      var.bucket-dr-arn,
      "${var.bucket-dr-arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = [var.s3-replication-role-arn]
    }

    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags"
    ]
    resources = [
      var.bucket-dr-arn,
      "${var.bucket-dr-arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "sb-s3-spa-policy-document" {

  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.access-origin.iam_arn]
    }

    sid     = "OnlyCloudFrontReadAccess"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      var.bucket-arn,
      "${var.bucket-arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:role/administrator"]
    }

    sid     = "AllowSayerBrinkAdmins"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      var.bucket-arn,
      "${var.bucket-arn}/*"
    ]
  }



  statement {
    principals {
      type        = "AWS"
      identifiers = [var.s3-replication-role-arn]
    }

    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete"
    ]
    resources = [
      var.bucket-arn,
      "${var.bucket-arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = [var.s3-replication-role-arn]
    }

    effect = "Allow"
    actions = [
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl"
    ]
    resources = [
      var.bucket-arn,
      "${var.bucket-arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = [var.s3-replication-role-arn]
    }

    effect = "Allow"
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    resources = [
      var.bucket-arn,
    ]
  }
}