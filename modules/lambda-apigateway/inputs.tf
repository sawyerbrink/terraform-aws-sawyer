variable "function-name" {
  type        = string
  description = "The name of the Lambda function"
}


variable "function-role-arn" {
  type        = string
  description = "IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
}

variable "runtime" {
  type        = string
  description = "Valid Values: nodejs10.x | nodejs12.x | java8 | java11 | python2.7 | python3.6 | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 | go1.x | ruby2.5 | ruby2.7 | provided"
}

variable "description" {
  type        = string
  description = "Description of what your Lambda Function does."
}

variable "timeout" {
  type        = number
  description = "The default timeout value for this lambda"
  default     = 15
}

variable "memory-size" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128"
  default     = 128
}

variable "source-code-hash" {
  type        = string
  description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key"
  default     = ""
}

variable "publish" {
  type        = bool
  description = "Whether to publish creation/change as new Lambda Function Version. Defaults to false."
}

variable "tags" {
  type        = map(any)
  description = "A map containing tag keys and values to pass to the function."
  default     = {}
}

variable "environment" {
  type        = map(any)
  description = "A map containing environment variable for the function to leverage"
  default     = {}
}

variable "subnet-ids" {
  type        = list(any)
  description = "A list of subnet IDs associated with the Lambda function"
  default     = []
}

variable "security-groups-ids" {
  type        = list(any)
  description = "A list of security group IDs associated with the Lambda function."
  default     = []
}

variable "kms-key-arn-lambda" {
  type        = string
  description = "Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables"
  default     = ""
}

variable "kms-key-arn-cloudwatch" {
  type        = string
  description = "Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt the cloudwatch log"
  default     = ""
}

variable "layers" {
  type        = list(any)
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function"
  default     = []
}

variable "reserved-concurrent-executions" {
  type        = number
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
  default     = -1
}

variable "dlq-target-arn" {
  type        = string
  description = "The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted."
  default     = ""
}

variable "tracing-mode" {
  type        = string
  description = "Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with \"sampled=1\". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
  default     = "PassThrough"
}

variable "alias" {
  type        = string
  description = "The name of alias to create for the Lambda function"
}

variable "alias-description" {
  type        = string
  description = "A description of the Lambda alias"
  default     = ""
}

variable "logs-retention" {
  type        = number
  description = "The number of days to retain the Cloudwatch logs in the log group"
  default     = 3
}

variable "api-source-arn" {
  type        = string
  description = "When the principal is an AWS service, the ARN of the specific resource within that service to grant permission to."
}

variable "s3-bucket-name" {
  type        = string
  description = "The bucket name where the Lambda code is stored."
}

variable "s3-key" {
  type        = string
  description = "The key name in s3 for the lambda code (file name)."
}


variable "code-signing-config-arn" {
  type        = string
  description = "Amazon Resource Name (ARN) for a Code Signing Configuration."
  default     = ""
}