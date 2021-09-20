variable "api-id" {
  type        = string
  description = "The ID of the target API"
}

variable "route-key" {
  type        = string
  description = "The route key, method/path. Example: GET /authors/{id}"
}

variable "api-key-requirement" {
  type        = bool
  description = "Setting that determines if an API key is required"
}

variable "authorization-type" {
  type        = string
  description = "The authorization type. Valid values are NONE | JWT"
}

variable "integration-type" {
  type        = string
  description = "The integration type of an integration. Valid values: AWS, AWS_PROXY, HTTP, HTTP_PROXY, MOCK"
  default     = "AWS_PROXY"
}

variable "connection-type" {
  type        = string
  description = "The type of the network connection to the integration endpoint. Valid values: INTERNET, VPC_LINK. Default is INTERNET."
  default     = "INTERNET"
}

variable "description" {
  type        = string
  description = "The description of the integration."
}

variable "integration-method" {
  type        = string
  description = "The integration's HTTP method. Must be specified if integration_type is not MOCK."
  default     = "POST"
}

variable "lambda-integration-uri" {
  type        = string
  description = "The URI of the Lambda function for a Lambda proxy integration, when integration_type is AWS_PROXY. For an HTTP integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service."
}

variable "passthrough-behavior" {
  type        = string
  description = "The pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the request_templates attribute. Valid values: WHEN_NO_MATCH, WHEN_NO_TEMPLATES, NEVER. Default is WHEN_NO_MATCH. Supported only for WebSocket APIs."
}

variable "payload-format" {
  type        = string
  description = "The format of the payload sent to an integration. Valid values: 1.0, 2.0. Default is 1.0."
  default     = "2.0"
}

variable "timeout" {
  type        = number
  description = "Custom timeout between 50 and 29,000 milliseconds. The default value is 29,000 milliseconds or 29 seconds."
  default     = 29000
}

variable "path-version" {
  type        = string
  description = "API Version path. Example: /v1/"
  default     = null
}

variable "authorizer-id" {
  type        = string
  description = "The id of the Cognito authorizer"
  default     = null
}