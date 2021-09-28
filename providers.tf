terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">3.0.0"
      configuration_aliases = [aws.dr]
    }
    null = {
      source = "hashicorp/null"
    }

    provider = {
      source = "hashicorp/random"
    }
  }
}