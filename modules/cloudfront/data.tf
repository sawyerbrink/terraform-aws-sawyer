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
      data.aws_s3_bucket.source-code-dr.arn,
      "${data.aws_s3_bucket.source-code-dr.arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/administrator"]
    }

    sid     = "AllowSayerBrinkAdmins"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      data.aws_s3_bucket.source-code-dr.arn,
      "${data.aws_s3_bucket.source-code-dr.arn}/*"
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
      data.aws_s3_bucket.source-code-dr.arn,
      "${data.aws_s3_bucket.source-code-dr.arn}/*"
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
      data.aws_s3_bucket.source-code.arn,
      "${data.aws_s3_bucket.source-code.arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/administrator"]
    }

    sid     = "AllowSayerBrinkAdmins"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      data.aws_s3_bucket.source-code.arn,
      "${data.aws_s3_bucket.source-code.arn}/*"
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
      data.aws_s3_bucket.source-code.arn,
      "${data.aws_s3_bucket.source-code.arn}/*"
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
      data.aws_s3_bucket.source-code.arn,
      "${data.aws_s3_bucket.source-code.arn}/*"
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
      data.aws_s3_bucket.source-code.arn,
    ]
  }
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "hosted_zone" {
  name = var.hosted-zone-name
}

data "aws_s3_bucket" "source-code" {
  bucket = var.bucket-name
}

data "aws_s3_bucket" "source-code-dr" {
  provider = aws.dr
  bucket   = var.bucket-dr-name
}