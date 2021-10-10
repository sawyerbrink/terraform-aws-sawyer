resource "aws_cognito_user_pool" "user-pool" {
  name = "${var.name}-users-tf"

  auto_verified_attributes = var.cognito-auto-verify-attrs

  mfa_configuration = var.mfa_configuration
  dynamic "software_token_mfa_configuration" {
    # enable if mfa is not OFF, so either ON or OPTIONAL
    for_each = var.mfa_configuration != "OFF" ? [1] : []
    content {
      # enabled = var.software_token_mfa_configuration_enabled
      enabled = true
    }
  }


  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 3
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
    invite_message_template {
      email_message = "Welcome to ${var.name}!\n Your username is {username} and temporary password is {####}.\n The temporary password is valid for 72 hrs. "
      email_subject = "SawyerBrink Temp credentials"
      sms_message   = "Welcome to SawyerBrink!\n Your username is {username} and temporary password is {####}.\n The temporary password is valid for 72 hrs. "
    }
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = "0"
      max_length = "2048"
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "organization"
    required                 = false

    string_attribute_constraints {
      max_length = "23"
      min_length = "1"
    }
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false
    string_attribute_constraints {
      min_length = "0"
      max_length = "2048"
    }
  }

  email_verification_subject = "${var.name} User Verification Code"
  email_verification_message = "<div><h1> Welcome to Sawyer!</1></div><div><p>Your verification code is {####}.</p></div>"

  email_configuration {
    source_arn            = var.ses-email-arn
    email_sending_account = var.ses-email-arn != "" ? "DEVELOPER" : "COGNITO_DEFAULT"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  lambda_config {
    pre_sign_up = aws_lambda_alias.preSignUp-trigger-alias.arn
  }
}

resource "aws_cognito_user_pool_client" "implicit-flow-client" {
  name = "implicit-flow-users"

  user_pool_id = aws_cognito_user_pool.user-pool.id

  generate_secret = false

  explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]

  read_attributes  = ["address", "birthdate", "email", "email_verified", "family_name", "gender", "given_name", "locale", "middle_name", "name", "nickname", "phone_number", "phone_number_verified", "picture", "preferred_username", "profile", "zoneinfo", "updated_at", "website"]
  write_attributes = ["address", "birthdate", "email", "family_name", "gender", "given_name", "locale", "middle_name", "name", "nickname", "phone_number", "picture", "preferred_username", "profile", "zoneinfo", "updated_at", "website"]

  refresh_token_validity        = 7
  prevent_user_existence_errors = "ENABLED"

  allowed_oauth_flows  = ["implicit"]
  allowed_oauth_scopes = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]

  callback_urls                        = ["https://ui.${var.environment}.${var.domain-name}"]
  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers         = ["COGNITO"]
  default_redirect_uri                 = "https://ui.${var.environment}.${var.domain-name}"
  logout_urls                          = ["https://ui.${var.environment}.${var.domain-name}/signout"]

}


resource "aws_cognito_user_pool_client" "authorized-flow-client" {
  name = "authorized-flow-users"

  user_pool_id = aws_cognito_user_pool.user-pool.id

  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true

  allowed_oauth_flows          = ["code"]
  allowed_oauth_scopes         = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  explicit_auth_flows          = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  supported_identity_providers = ["COGNITO"]


  prevent_user_existence_errors = "ENABLED"

  read_attributes  = ["address", "birthdate", "email", "email_verified", "family_name", "gender", "given_name", "locale", "middle_name", "name", "nickname", "phone_number", "phone_number_verified", "picture", "preferred_username", "profile", "zoneinfo", "updated_at", "website"]
  write_attributes = ["address", "birthdate", "email", "family_name", "gender", "given_name", "locale", "middle_name", "name", "nickname", "phone_number", "picture", "preferred_username", "profile", "zoneinfo", "updated_at", "website"]


  refresh_token_validity = 7
  callback_urls          = ["https://ui.${var.environment}.${var.domain-name}"]
  logout_urls            = ["https://ui.${var.environment}.${var.domain-name}/signout"]
}



resource "aws_cognito_user_pool_domain" "cognito-domain" {
  domain       = "${lower(var.name)}-sawyerbrink"
  user_pool_id = aws_cognito_user_pool.user-pool.id
  # certificate_arn = data.aws_acm_certificate.auth-cert.arn
}

resource "aws_cognito_user_group" "admin-group" {
  name         = "${var.org-id}-admin"
  user_pool_id = aws_cognito_user_pool.user-pool.id
  description  = "Administration group"
  precedence   = 1

  depends_on = [
    aws_cognito_user_pool.user-pool
  ]

  lifecycle {
    create_before_destroy = true
    # The orgId forces a replacement
    ignore_changes = [name]
  }
}

resource "aws_cognito_user_group" "non-admin-group" {
  name         = "${var.org-id}-non-admin"
  user_pool_id = aws_cognito_user_pool.user-pool.id
  description  = "Non-admin user group"
  precedence   = 2

  depends_on = [
    aws_cognito_user_pool.user-pool
  ]

  lifecycle {
    create_before_destroy = true
    # The orgId forces a replacement
    ignore_changes = [name]
  }
}