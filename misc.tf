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

data "null_data_source" "values" {
 // Ignore the deprecation warning. A locals variable will regenerate the value in each Terraform run. We need to this value to only be generated once.
 // As of Terraform 1.0.7
  inputs = {
    org_id = "o${formatdate("05040302012006", timestamp())}${substr(uuidv5("6ba7b810-9dad-11d1-80b4-00c04fd430c8", var.name), 0, 8)}"
  }
}