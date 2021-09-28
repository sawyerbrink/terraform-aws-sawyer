resource "aws_s3_bucket_policy" "logging-storage-bucket-policy" {
  bucket = data.aws_s3_bucket.source-code.id

  policy = data.aws_iam_policy_document.sb-s3-spa-policy-document.json
}

resource "aws_s3_bucket_policy" "logging-storage-bucket-dr-policy" {
  provider = aws.dr
  bucket   = data.aws_s3_bucket.source-code-dr.id

  policy = data.aws_iam_policy_document.sb-s3-spa-dr-policy-document.json
}