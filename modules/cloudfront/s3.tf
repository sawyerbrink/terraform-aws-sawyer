resource "aws_s3_bucket_policy" "logging-storage-bucket-policy" {
  bucket = var.bucket-name

  policy = data.aws_iam_policy_document.sb-s3-spa-policy-document.json
}

resource "aws_s3_bucket_policy" "logging-storage-bucket-dr-policy" {
  provider = aws.dr
  bucket   = var.bucket-dr-name

  policy = data.aws_iam_policy_document.sb-s3-spa-dr-policy-document.json
}