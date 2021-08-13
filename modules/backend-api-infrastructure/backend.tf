terraform {
  backend "remote" {
    organization = "SawyerBrink"

    workspaces {
      name = "backend-api-prod-us-east-1"
    }
  }
}
