terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">3.0.0"
    }
    null = {
      source = "hashicorp/null"
    }

    provider = {
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = var.profile
  assume_role {
    role_arn = "arn:aws:iam::${var.account_number}:role/administrator"
  }
  default_tags {
    tags = var.tags
  }
}

# Disaster Recovery region
provider "aws" {
  region  = "us-west-2"
  alias   = "dr"
  profile = var.profile
  assume_role {
    role_arn = "arn:aws:iam::${var.account_number}:role/administrator"
  }
  default_tags {
    tags = var.tags
  }
}