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
  region  = var.region
  profile = var.profile
  default_tags {
    tags = var.tags
  }
}

