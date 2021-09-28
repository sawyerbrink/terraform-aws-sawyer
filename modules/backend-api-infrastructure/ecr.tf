resource "aws_ecr_repository" "sb-registry" {
  name                 = "${lower(var.name)}-risk-sensing"
  image_tag_mutability = var.ecr-image-tag-mutability

  image_scanning_configuration {
    scan_on_push = false
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = var.kms-key-arn
  }
}

resource "aws_ecr_lifecycle_policy" "default-policy" {
  repository = aws_ecr_repository.sb-registry.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Only keep 3 tagged images at most",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": [
                    "v"
                ],
                "countType": "imageCountMoreThan",
                "countNumber": 3
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire untagged images",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
