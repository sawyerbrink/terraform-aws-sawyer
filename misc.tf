resource "random_string" "id" {
  keepers = {
    # Generate a new random string each time a new name is provided.
    regenerate = var.name
  }
  length  = 5
  special = false
}

// Generates a random password for the RDS DB
resource "random_password" "db-password" {

  keepers = {
    "static" = var.backendinfra-ds-db-master-password
  }

  length           = 16
  special          = true
  override_special = "_%@"
}