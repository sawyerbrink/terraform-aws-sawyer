
data "aws_s3_bucket_objects" "my_objects" {
  bucket = "sawyerbrink-website-assets-${var.website-repository-region}"
  prefix = var.sawyer-version
}

## The AWS CLI must be used to circumvent the limitation of count and for_each not accepting dynamic values
## The alternative is to seperate the execution through two different Terraform runs
resource "null_resource" "copy-website-assets-profile" {
  count = var.profile != "" ? 1 : 0

  triggers = {
    id = var.sawyer-version
  }

  provisioner "local-exec" {
    command = <<EOT
            aws s3 rm s3://${aws_s3_bucket.code-storage.id} --recursive --profile ${var.profile}
         %{for key in data.aws_s3_bucket_objects.my_objects.keys}
            aws s3api copy-object --profile ${var.profile} --copy-source sawyerbrink-website-assets-${var.website-repository-region}/${key} --key ${substr(key, 6, -1)} --bucket ${aws_s3_bucket.code-storage.id} --acl private
         %{endfor~} 
    EOT
  }
  depends_on = [local_file.s3-replication-config, aws_s3_bucket.code-storage, aws_s3_bucket.code-storage-DR]
}

resource "null_resource" "copy-website-assets" {
  count = var.profile == "" ? 1 : 0

  triggers = {
    id = var.sawyer-version
  }

  provisioner "local-exec" {
    command = <<EOT
            aws s3 rm s3://${aws_s3_bucket.code-storage.id} --recursive
         %{for key in data.aws_s3_bucket_objects.my_objects.keys}
            aws s3api copy-object --copy-source sawyerbrink-website-assets-${var.website-repository-region}/${key} --key ${substr(key, 6, -1)} --bucket ${aws_s3_bucket.code-storage.id} --acl private
         %{endfor~} 
    EOT
  }
  depends_on = [local_file.s3-replication-config, aws_s3_bucket.code-storage, aws_s3_bucket.code-storage-DR]
}