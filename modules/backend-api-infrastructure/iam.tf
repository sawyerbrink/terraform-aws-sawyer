########################################
# Lambdas - API Gateway Execution Role
#######################################
data "aws_iam_policy_document" "lambda-instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-role" {
  name               = "LambdaExecution-API-role"
  description        = "This is the main role for Sawyer Lambdas related to the API methods"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.lambda-instance-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda-role-attach-kms" {
  role       = aws_iam_role.lambda-role.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_role_policy" "corePermissions" {
  name = "Lambda-Core-Permissions"
  role = aws_iam_role.lambda-role.id

  policy = data.aws_iam_policy_document.core-permission.json
}

data "aws_iam_policy_document" "core-permission" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:GetItem",
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "${aws_dynamodb_table.organization-table.arn}/index/*"
    ]
  }
  statement {
    actions = [
      "dynamodb:DescribeLimits"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "${aws_dynamodb_table.organization-table.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "rds-db:connect"
    ]
    resources = [
      "arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.postgresql-rds.cluster_resource_id}/${var.rds-read-role}",
      "arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.postgresql-rds.cluster_resource_id}/${var.rds-write-role}"
    ]
  }

  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [
      "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.newslitapi-parameter-name}",
    ]
  }

  statement {
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.audit-queue.arn,
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "ssm:DescribeParameters"
    ]

    resources = [
      "*"
    ]
  }

  // For Attaching a Lambda to a VPC
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces"
    ]

    resources = [
      "*"
    ]
  }

  # TODO - We need to split this out for the admin API, due to circular dependency and lack of data lookup, we have to use *
  #
  statement {
    actions = [
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "execute-api:Invoke",
      "execute-api:ManageConnections"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*/v${var.api-version}/*"
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }
}
#######################################
# Lambda Write RDS Role
######################################
data "aws_iam_policy_document" "lambda-rds-instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-rds-role" {
  name               = "LambdaExecution-RDS-write-role"
  description        = "This is the main role for Sawyer Lambdas related to the RDS access"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.lambda-rds-instance-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda-rds-role-attach-kms" {
  role       = aws_iam_role.lambda-rds-role.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_role_policy" "corePermissions-rds" {
  name = "Lambda-rds-Core-Permissions"
  role = aws_iam_role.lambda-rds-role.id

  policy = data.aws_iam_policy_document.core-rds-permission.json
}

data "aws_iam_policy_document" "core-rds-permission" {
  statement {
    actions = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]

    resources = [
      "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${aws_dynamodb_table.organization-table.id}/stream/*"
    ]
  }


  statement {
    actions = [
      "rds-db:connect"
    ]

    resources = [
      "arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.postgresql-rds.cluster_resource_id}/${var.rds-write-role}"
    ]
  }


  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "ssm:DescribeParameters"
    ]

    resources = [
      "*"
    ]
  }

  // For Attaching a Lambda to a VPC
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }
}

########################################
# API Gateway Cloudwatch Role
#######################################
data "aws_iam_policy_document" "ApigatewayCloudwatch-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "APIGatwayCloudwatch-role" {
  name               = "APIGatwayCloudwatch-role"
  description        = "This is the main role for Sawyer APIGateway to push logs to Cloudwatch"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.ApigatewayCloudwatch-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "APIGatwayCloudwatch-attachment" {
  role       = aws_iam_role.APIGatwayCloudwatch-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

########################################
# Lambdas - SQS AuditingRole
#######################################
data "aws_iam_policy_document" "SQS-access-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-sqs-role" {
  name               = "SQS-Access-Lambda-Role"
  description        = "This is the main role for Sawyer Lambdas accessing SQS for auditing purposes"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.SQS-access-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda-sqs-role-attach-kms" {
  role       = aws_iam_role.lambda-sqs-role.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_role_policy" "main-permissions" {
  name = "SQS-Access-Lambda-Role-Permissions"
  role = aws_iam_role.lambda-sqs-role.id

  policy = data.aws_iam_policy_document.sqs-core-permission.json
}

data "aws_iam_policy_document" "sqs-core-permission" {
  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
      "sqs:GetQueueUrl",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:ChangeMessageVisibility"
    ]

    resources = [
      aws_sqs_queue.audit-queue.arn,
      aws_sqs_queue.customer-documents-queue.arn
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectRetention",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketVersioning",
      "s3:GetBucketTagging",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.logging-storage.arn,
      "${aws_s3_bucket.logging-storage.arn}/*"
    ]
  }


  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }
}
########################################
# Lambdas - LambdaWriteReadS3
#######################################
data "aws_iam_policy_document" "lambda-s3readwrite-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-role-s3" {
  name               = "auditing-s3-lambda-role"
  description        = "This is the main role for Sawyer Lambdas related to the S3 methods"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.lambda-s3readwrite-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda-role-s3-attach-kms" {
  role       = aws_iam_role.lambda-role-s3.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_role_policy" "corePermissions-s3ReadWrite" {
  name = "Lambda-Core-Permissions"
  role = aws_iam_role.lambda-role-s3.id

  policy = data.aws_iam_policy_document.core-permission-lambdas3.json
}

data "aws_iam_policy_document" "core-permission-lambdas3" {
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = [
      aws_s3_bucket.logging-storage.arn
    ]
  }
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      "${aws_s3_bucket.logging-storage.arn}/*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }
}
########################################
# CloudWatch Events - StartLambda
#######################################
data "aws_iam_policy_document" "cloudwatch-role-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cloudwatch-cron-log-role" {
  name               = "cloudwatch-cron-lambda-role"
  description        = "This is a role for Sawyer Cloudwatch Events to trigger the log aggregator Lambda"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch-role-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "cloudwatch-core-permissions" {
  name = "CLoudwatch-Core-Permissions"
  role = aws_iam_role.cloudwatch-cron-log-role.id

  policy = data.aws_iam_policy_document.core-permission-lambdas3.json
}

data "aws_iam_policy_document" "cloudwatch-core-permission-statements" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}
########################################
# Lambdas - LambdaApiGatewayReadS3
#######################################
data "aws_iam_policy_document" "lambda-api-gateway-reads3-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-apigateway-role-s3" {
  name               = "APIGateway-s3read-lambda-role"
  description        = "This is the main role for Lambdas related to the API methods that can invoke S3 API functions"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.lambda-api-gateway-reads3-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda-apigateway-role-s3-attach-kms" {
  role       = aws_iam_role.lambda-apigateway-role-s3.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_role_policy" "corePermissions-s3Read" {
  name = "Lambda-Core-Permissions"
  role = aws_iam_role.lambda-apigateway-role-s3.id

  policy = data.aws_iam_policy_document.core-permission-lambdas-s3-apigateway.json
}

data "aws_iam_policy_document" "core-permission-lambdas-s3-apigateway" {
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = [
      aws_s3_bucket.logging-storage.arn
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl"
    ]

    resources = [
      "${aws_s3_bucket.logging-storage.arn}/*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "execute-api:Invoke",
      "execute-api:ManageConnections"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${module.apigateway-core.main-api-id}/v${var.api-version}/GET/logs/*"
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }
}
###############################################
# Lambdas - API Gateway Execution Role (Delete)
###############################################
data "aws_iam_policy_document" "lambda-instance-assume-role-policy-delete" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-role-delete" {
  name               = "LambdaExecution-API-delete-role"
  description        = "This is the main role for Lambdas related to the API methods of type DELETE"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.lambda-instance-assume-role-policy-delete.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda-role-delete-attach-kms" {
  role       = aws_iam_role.lambda-role-delete.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_role_policy" "corePermissions-delete" {
  name = "Lambda-Core-Permissions"
  role = aws_iam_role.lambda-role-delete.id

  policy = data.aws_iam_policy_document.core-permission-delete.json
}

data "aws_iam_policy_document" "core-permission-delete" {
  statement {
    actions = [
      "dynamodb:DescribeLimits"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "${aws_dynamodb_table.organization-table.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.audit-queue.arn,
    ]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]

    resources = [
      "*",
    ]
  }


  statement {
    actions = [
      "rds-db:connect"
    ]
    resources = [
      "arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.postgresql-rds.cluster_resource_id}/${var.rds-write-role}"
    ]
  }

  // For Attaching a Lambda to a VPC
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:GetBucketCORS",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = [
      aws_s3_bucket.customers-documents.arn
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.customers-documents.arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "execute-api:Invoke",
      "execute-api:ManageConnections"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${module.apigateway-core.main-api-id}/v${var.api-version}/DELETE/audits/{audit_id}/documents*",
      "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${module.apigateway-core.main-api-id}/v${var.api-version}/DELETE/controls/*",
      "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${module.apigateway-core.main-api-id}/v${var.api-version}/DELETE/risks/*"
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }

  // For Attaching a Lambda to a VPC
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces"
    ]

    resources = [
      "*"
    ]
  }
}

########################################
# Lambdas - PresignedUrl-Role
#######################################
data "aws_iam_policy_document" "lambda-api-gateway-presignedUrl-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-apigateway-role-presigned-url" {
  name               = "APIGateway-presignedUrl-lambda-role"
  description        = "This is the main role for Lambdas related to the API methods that can read S3 for presignedUrl purposes"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.lambda-api-gateway-presignedUrl-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda-apigateway-role-presigned-url-attach-kms" {
  role       = aws_iam_role.lambda-apigateway-role-presigned-url.name
  policy_arn = local.default-kms-policy
}


resource "aws_iam_role_policy" "corePermissions-presigned-s3" {
  name = "Lambda-Core-Permissions"
  role = aws_iam_role.lambda-apigateway-role-presigned-url.id

  policy = data.aws_iam_policy_document.core-permission-lambdas-s3-presigned-apigateway.json
}


data "aws_iam_policy_document" "core-permission-lambdas-s3-presigned-apigateway" {
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:GetBucketCORS",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = [
      aws_s3_bucket.customers-documents.arn
    ]
  }
  statement {
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.audit-queue.arn
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      "${aws_s3_bucket.customers-documents.arn}/*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "execute-api:Invoke",
      "execute-api:ManageConnections"
    ]

    resources = [
      "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${module.apigateway-core.main-api-id}/v${var.api-version}/GET/presigned-url/*"
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }
}
########################################
# Lambdas - Index Document Lambda
#######################################
data "aws_iam_policy_document" "index-document-lambda-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "index-document-lambda" {
  name               = "IndexDocument-Lambda-role"
  description        = "This is the main role for Sawyer Lambdas related to the indexing customer documents"
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.index-document-lambda-assume-role-policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "index-document-lambda-attach-kms" {
  role       = aws_iam_role.index-document-lambda.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_role_policy" "corePermissions-index-document" {
  name = "Lambda-Core-Permissions"
  role = aws_iam_role.index-document-lambda.id

  policy = data.aws_iam_policy_document.index-document-core-permission.json
}

data "aws_iam_policy_document" "index-document-core-permission" {

  statement {
    actions = [
      "dynamodb:DescribeLimits"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "${aws_dynamodb_table.organization-table.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
      "sqs:GetQueueUrl",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:ChangeMessageVisibility"
    ]

    resources = [
      aws_sqs_queue.customer-documents-queue.arn,
      aws_sqs_queue.deadletter-customer-documents-queue.arn
    ]
  }

  statement {
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.deadletter-customer-documents-queue.arn
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
    ]
  }

  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [data.aws_sns_topic.sawyerbrink-support.arn]
  }
}

##############################################
# AWS Batch
##############################################
data "aws_iam_policy_document" "ecs_instance_role_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs_batch_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_role_trust.json
  tags               = var.tags
  depends_on         = [aws_cloudwatch_log_group.aws_batch]
}

resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "ecs_batch_instance_role"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_policy" "ecs-instance-managed-policy" {
  name        = "ecs-instance-role-permissions"
  path        = "/sawyer/"
  description = "IAM Managed policy for Sawyer ECS Instance Role"
  policy      = data.aws_iam_policy_document.ecs_instance_role_permissions.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = aws_iam_policy.ecs-instance-managed-policy.arn

  // This used to prevent circular dependency with the cluster creation and the role. Adding permissions after the cluster and related resources have been created.
  depends_on = [aws_batch_compute_environment.batch-compute-environment, aws_ecr_repository.sb-registry, aws_cloudwatch_log_group.aws_batch]
}

data "aws_iam_policy_document" "ecs_instance_role_permissions" {
  statement {
    actions = [
      "ecs:CreateCluster",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:StartTelemetrySession",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecs:DeregisterContainerInstance",
      "ecs:RegisterContainerInstance",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
    ]
    resources = [aws_batch_compute_environment.batch-compute-environment.ecs_cluster_arn]
  }

  statement {
    actions   = ["ec2:DescribeTags"]
    resources = ["*"]
  }

  statement {
    actions = [
      "rds-db:connect"
    ]
    resources = [
      "arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.postgresql-rds.cluster_resource_id}/${var.rds-write-role}"
    ]
  }

  statement {
    actions = [
      "rds:StartDBCluster",
      "rds:StartDBInstance",
      "rds:StopDBCluster",
      "rds:StopDBInstance",
    ]
    resources = [aws_rds_cluster.postgresql-rds.arn]
  }

  statement {
    actions = [
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

    resources = [aws_ecr_repository.sb-registry.arn]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:Describe*"
    ]

    resources = ["${aws_cloudwatch_log_group.aws_batch.arn}:*"]
  }

  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    resources = ["${aws_cloudwatch_log_group.aws_batch.arn}:log-stream:*"]
  }
}

data "aws_iam_policy_document" "aws_batch_service_role_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "batch.amazonaws.com"
      ]
    }
  }
}


resource "aws_iam_role" "aws_batch_service_role" {
  name               = "aws_batch_service_role"
  tags               = var.tags
  assume_role_policy = data.aws_iam_policy_document.aws_batch_service_role_trust.json
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
  role       = aws_iam_role.aws_batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role_policy_attachment_kms" {
  role       = aws_iam_role.aws_batch_service_role.name
  policy_arn = local.default-kms-policy
}

######################
# ECS Task Role
######################
data "aws_iam_policy_document" "aws_ecs_task_role_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "aws_ecs_task_role" {
  name               = "ecs_task_role"
  description        = "The Sawyer ECS Task role for Risk Sensing Batch"
  assume_role_policy = data.aws_iam_policy_document.aws_ecs_task_role_trust.json


}

resource "aws_iam_policy" "aws_ecs_task_role_policy" {
  name        = "sb-ecs-container-policy"
  path        = "/saywer/"
  description = "Default Saywer ECS Task IAM Policy"

  policy = data.aws_iam_policy_document.ecs_instance_task_permissions.json
}


resource "aws_iam_role_policy_attachment" "aws_ecs_task_role_policy_attachment_core" {
  role       = aws_iam_role.aws_ecs_task_role.name
  policy_arn = aws_iam_policy.aws_ecs_task_role_policy.arn
}


resource "aws_iam_role_policy_attachment" "aws_ecs_task_role_policy_attachment_kms" {
  role       = aws_iam_role.aws_ecs_task_role.name
  policy_arn = local.default-kms-policy
}

data "aws_iam_policy_document" "ecs_instance_task_permissions" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
    resources = [aws_ecr_repository.sb-registry.arn]
  }

  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    actions = [
      "rds:StartDBCluster",
      "rds:StartDBInstance",
      "rds:StopDBCluster",
      "rds:StopDBInstance",
    ]
    resources = [aws_rds_cluster.postgresql-rds.arn]
  }

  statement {
    actions = [
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "rds-db:connect"
    ]
    resources = [
      "arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.postgresql-rds.cluster_resource_id}/${var.rds-read-role}",
    ]
  }


  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:Describe*"
    ]

    resources = ["${aws_cloudwatch_log_group.aws_batch.arn}:*"]
  }

  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    resources = ["${aws_cloudwatch_log_group.aws_batch.arn}*:log-stream:*"]
  }

  statement {
    actions = [
      "ssm:GetParameter"
    ]
    resources = [data.aws_ssm_parameter.newslit-api-key.arn]
  }

  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "${aws_dynamodb_table.organization-table.arn}/index/*"
    ]
  }
  statement {
    actions = [
      "dynamodb:DescribeLimits"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
      "${aws_dynamodb_table.organization-table.arn}/index/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      aws_dynamodb_table.organization-table.arn,
    ]
  }


  statement {
    actions = [
      "sns:Publish"
    ]

    resources = [data.terraform_remote_state.support-infra.outputs.sb-support-sns-arn]
  }
}
################################
# Lambda Batch Trigger Role
###############################
data "aws_iam_policy_document" "lambda-s3-trigger-trust-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda-batch-trigger-role" {
  name               = "lambda-submit-batch-job"
  description        = "This role triggers a Lambda that submits an AWS Batch Job."
  path               = "/sawyer/"
  assume_role_policy = data.aws_iam_policy_document.lambda-s3-trigger-trust-policy.json
  tags               = var.tags
}



resource "aws_iam_role_policy_attachment" "lambda-batch-trigger-role-policy-attachment" {
  role       = aws_iam_role.lambda-batch-trigger-role.name
  policy_arn = aws_iam_policy.lambda-trigger-batch-policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda-batch-trigger-role-policy-attachmentkms" {
  role       = aws_iam_role.lambda-batch-trigger-role.name
  policy_arn = local.default-kms-policy
}

resource "aws_iam_policy" "lambda-trigger-batch-policy" {
  name = "sb-lambda-trigger-batch-policy"
  path = "/sawyer/"

  policy = data.aws_iam_policy_document.lambda-submit-batch-job-core-permission.json
}

data "aws_iam_policy_document" "lambda-submit-batch-job-core-permission" {
  statement {
    actions = [
      "batch:SubmitJob"
    ]

    resources = [
      aws_batch_job_queue.batch-compute-queue.arn,
      aws_batch_job_definition.batch-compute-job-definition.arn
    ]
  }


  statement {
    actions = [
      # "datapipeline:ActivatePipeline",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "sns:Publish"
    ]

    resources = [var.support-sns-topic]
  }
}

data "aws_iam_policy_document" "iam-kms-policy" {
  count = local.default-kms-policy != "" ? 0 : 1
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:RevokeGrant",
      "kms:RetireGrant",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:List*"
    ]
    resources = [
      var.kms-key-arn
    ]
  }
}

resource "aws_iam_policy" "iam-kms-policy" {
  count       = local.default-kms-policy != "" ? 0 : 1
  name        = "${var.name}-iam-kms-grant-policy"
  path        = "/sawyer/"
  description = "IAM policy that grants access to the main kms key"
  policy      = data.aws_iam_policy_document.iam-kms-policy.json
}