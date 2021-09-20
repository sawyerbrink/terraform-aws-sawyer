module "apigateway-routes-us-east-1" {
  for_each = var.apigateway-routes
  ##################
  # Global Settings
  #################
  source               = "../apigateway-v2-route-integration"
  api-id               = var.api-id
  api-key-requirement  = false
  payload-format       = var.payload-format
  passthrough-behavior = var.passthrough-behavior
  authorization-type   = var.authorization-type
  authorizer-id        = var.authorizer-id
  description          = "Integrates with the ${each.key} Lambda"
  ############################
  # Route Specific Settings
  ############################
  timeout                = each.value.timeout
  route-key              = "${each.value.route-method} /v${var.api-version}${each.value.route-key}"
  lambda-integration-uri = module.lambdas[each.key].alias_invoke_arn
  ####################
  # Dependencies
  ####################
}

#################################
# API Gateway - getLogs
#################################
module "getLogs-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "GET /v${var.api-version}/logs"
  description            = "Integrates with the getLogs Lambda"
  lambda-integration-uri = module.getLogs-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id


}

#################################
# API Gateway - deleteAudit
#################################
module "deleteAudit-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "DELETE /v${var.api-version}/audits/{audit_id}"
  description            = "Integrates with the deleteAudit Lambda"
  lambda-integration-uri = module.deleteAudit-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id

}


#################################
# API Gateway - deleteControl
#################################
module "deleteControl-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "DELETE /v${var.api-version}/controls/{control_id}"
  description            = "Integrates with the deleteControl Lambda"
  lambda-integration-uri = module.deleteControl-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id

}

#################################
# API Gateway - deleteRisk
#################################
module "deleteRisk-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "DELETE /v${var.api-version}/risks/{risk_id}"
  description            = "Integrates with the deleteRisks Lambda"
  lambda-integration-uri = module.deleteRisk-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id

}

#################################
# API Gateway - deleteRisk
#################################
module "getPresignedUrl-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "GET /v${var.api-version}/presigned-url"
  description            = "Integrates with the getPresignedUrl Lambda"
  lambda-integration-uri = module.getPresignedUrl-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id

}

###################################
# API Gateway - deleteAuditDocument
###################################
module "deleteAuditDocument-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "DELETE /v${var.api-version}/audits/{audit_id}/documents"
  description            = "Integrates with the deleteAuditDocument Lambda"
  lambda-integration-uri = module.deleteAuditDocument-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id

}

###################################
# API Gateway - deleteControlsDocuments
###################################
module "deleteControlsDocuments-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "DELETE /v${var.api-version}/controls/{control_id}/documents"
  description            = "Integrates with the deleteAuditDocument Lambda"
  lambda-integration-uri = module.deleteControlsDocuments-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id
}

######################################
# API Gateway - deleteRisksDocuments
######################################
module "deleteRisksDocuments-route" {
  source = "../apigateway-v2-route-integration"

  api-id                 = var.api-id
  api-key-requirement    = false
  route-key              = "DELETE /v${var.api-version}/risks/{risk_id}/documents"
  description            = "Integrates with the deleteRisksDocuments Lambda"
  lambda-integration-uri = module.deleteRisksDocuments-lambda.alias_invoke_arn
  passthrough-behavior   = var.passthrough-behavior
  payload-format         = var.payload-format
  timeout                = var.route-timeout
  authorization-type     = var.authorization-type
  authorizer-id          = var.authorizer-id

}