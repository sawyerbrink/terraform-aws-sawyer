variable "api-name" {
  type        = string
  description = "The name of the API"
}

variable "api-version" {
  type        = string
  description = "The version of the API"
}

variable "stage-name" {
  type        = string
  description = "The name of the stage defined for the API"
}

variable "protocol-type" {
  type        = string
  description = "The protocol type for the API Gateway. Valid values are: HTTP | WEBSOCKET"
}

variable "api-description" {
  type        = string
  description = "A decription of the API"
}

variable "auto-deploy" {
  type        = bool
  description = "The setting for auto-deploy within the created stage. Default value is false"
  default     = false
}

variable "cors-allow-credentials" {
  type        = bool
  description = "(Optional) Whether credentials are included in the CORS request"
  default     = false
}


variable "cors-allow-headers" {
  type        = list(any)
  description = "(Optional) The set of allowed HTTP headers."
  default     = []
}


variable "cors-allow-methods" {
  type        = list(any)
  description = "(Optional) The set of allowed HTTP methods."
  default     = []
}

variable "cors-allow-origins" {
  type        = list(any)
  description = "(Optional) The set of allowed origins"
  default     = []
}

variable "cors-expose-headers" {
  type        = list(any)
  description = "(Optional) The set of exposed HTTP headers"
  default     = []
}

variable "cors-max-age" {
  type        = number
  description = "(Optional) The number of seconds that the browser should cache preflight request results."
  default     = 300
}

variable "destination-log-group-arn" {
  type        = string
  description = "The ARN of the CloudWatch Logs log group to receive access logs. Any trailing :* is trimmed from the ARN"
}

variable "access-log-format" {
  type        = string
  description = "A single line format of the access logs of data, as specified by selected $context variables."
  default     = "{ \"requestId\":\"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"requestTime\":\"$context.requestTime\", \"httpMethod\":\"$context.httpMethod\",\"routeKey\":\"$context.routeKey\", \"status\":\"$context.status\",\"protocol\":\"$context.protocol\", \"responseLength\":\"$context.responseLength\" }"
}

variable "route-keys" {
  type        = list(any)
  description = "A list of route keys to enable logging"
  default     = []
}

variable "default-burst-limit" {
  type        = number
  description = "The throttling burst limit for the default route"
  default     = 1000
}

variable "default-rate-limit" {
  type        = number
  description = "The throttling rate limit for the default route"
  default     = 100
}

variable "audience" {
  type        = list(any)
  description = "A list of the intended recipients of the JWT. A valid JWT must provide an aud that matches at least one entry in this list."
  default     = []
}

variable "auth-endpoint" {
  type        = string
  description = "The base domain of the identity provider that issues JSON Web Tokens"
  default     = ""
}

variable "disable-default-endpoint" {
  type        = bool
  description = "Enable/Disable the deafault API Gateway exposed by API Gateway"
  default     = false
}

variable "authorizer_type" {
  type        = string
  description = "The authorization type to use"
}