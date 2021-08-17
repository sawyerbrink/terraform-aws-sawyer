data "aws_kms_key" "main-key-alias" {
  key_id = "alias/main-${var.region}-${var.environment}"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# data "terraform_remote_state" "support-infra" {
#   backend = "remote"

#   config = {
#     organization = "SawyerBrink"
#     workspaces = {
#       name = "sawyerbrink-${var.environment}-us-east-1"
#     }
#   }
# }

data "aws_route53_zone" "primary" {
  name         = var.api-domain-name
  private_zone = false
}

data "aws_acm_certificate" "api-cert" {
  domain   = var.api-domain-name
  statuses = ["ISSUED"]
}

data "aws_iam_policy" "kms-policy" {
  arn = "arn:aws:iam::${data.aws_caller_identity.current.id}:policy/sb-kms-allow"
}

data "aws_sns_topic" "sawyerbrink-support" {
  name = var.support-sns-topic
}

data "aws_vpc" "selected" {
  id = data.terraform_remote_state.support-infra.outputs.vpc-id
}

data "aws_subnet_ids" "sb-vpc" {
  vpc_id = data.terraform_remote_state.support-infra.outputs.vpc-id
}

data "aws_security_groups" "sb-list" {
  filter {
    name   = "tag:Name"
    values = ["sawyerbrink-${var.environment}-${var.region}-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.terraform_remote_state.support-infra.outputs.vpc-id]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ssm_parameter" "newslit-api-key" {
  name            = "Newslit-API"
  with_decryption = true
}

data "aws_ssm_parameter" "db-password" {
  name            = "aurora-db-password"
  with_decryption = true
}

data "aws_s3_bucket_objects" "signedLambdas" {
  bucket = local.codeBucket
  prefix = "${var.environment}/signed/"
}


data "aws_s3_bucket_object" "object_info" {
  count  = length(local.signedSourceList)
  key    = element(local.signedSourceList, count.index)
  bucket = local.codeBucket
}
