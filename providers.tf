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

resource "random_string" "id" {
  keepers = {
    # Generate a new random string each time a new name is provided.
    regenerate = var.name
  }
  length  = 5
  special = false
}