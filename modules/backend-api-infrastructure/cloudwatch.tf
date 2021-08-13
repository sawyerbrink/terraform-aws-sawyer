resource "aws_cloudwatch_log_group" "APIGateway-log-group" {
  name              = "SawyerBrinkAPI-logs"
  retention_in_days = 1
  tags              = var.tags
  kms_key_id        = data.aws_kms_key.main-key-alias.arn
}

resource "aws_cloudwatch_dashboard" "organization-table" {
  dashboard_name = "SawyerBrink-API"
  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 24,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/DynamoDB", "ProvisionedReadCapacityUnits", "TableName", "${aws_dynamodb_table.organization-table.id}" ],
                    [ ".", "ConsumedReadCapacityUnits", ".", "." ],
                    [ ".", "ConsumedWriteCapacityUnits", ".", "." ],
                    [ ".", "ProvisionedWriteCapacityUnits", ".", "." ]
                ],
                "region": "${var.region}",
                "title": "DynamoDB Organization Table",
                "period": 300,
                "width": 1840,
                "height": 250
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 6,
            "width": 24,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Lambda", "Duration" ],
                    [ ".", "Errors" ]
                ],
                "region": "${var.region}",
                "title": "Lambdas - Duration, Errors",
                "period": 300,
                "width": 1840,
                "height": 250
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 12,
            "width": 6,
            "height": 3,
            "properties": {
                "view": "singleValue",
                "metrics": [
                    [ "AWS/ApiGateway", "Latency", "ApiId", "${module.apigateway-core.main-api-id}" ]
                ],
                "region": "${var.region}",
                "title": "API - Latency",
                "period": 300,
                "width": 1840,
                "height": 250
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 12,
            "width": 18,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/ApiGateway", "IntegrationLatency", "ApiId", "${module.apigateway-core.main-api-id}" ]
                ],
                "region": "${var.region}"
            }
        }
    ]
}
  EOF
}
resource "aws_cloudwatch_metric_alarm" "api_5xx_threshold" {
  alarm_name          = "api-5xx-threshhold-tf"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "5xx"
  dimensions = {
    ApiName = module.apigateway-core.main-api-id
  }
  namespace                 = "AWS/ApiGateway"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "5"
  alarm_description         = "This metric monitors API 5xx return codes"
  insufficient_data_actions = []
  tags                      = var.tags
  alarm_actions             = [data.aws_sns_topic.sawyerbrink-support.arn]
}

resource "aws_cloudwatch_log_group" "aws_batch" {
  name              = "/aws/batch/job"
  retention_in_days = 1
  tags              = var.tags
}
##################################
# DeadLetter Cloud Watch Alarm
#################################
resource "aws_cloudwatch_metric_alarm" "audit-deadLetterQueue" {
  alarm_name          = "auditDeadLetterQueue-tf"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  dimensions = {
    QueueName = aws_sqs_queue.deadletter-audit-queue.id
  }
  namespace                 = "AWS/SQS"
  period                    = "3600"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric monitors SQS Dead Letter Queue > 0"
  insufficient_data_actions = []
  tags                      = var.tags
  alarm_actions             = [data.aws_sns_topic.sawyerbrink-support.arn]
}

resource "aws_cloudwatch_metric_alarm" "customer-documents-deadLetterQueue" {
  alarm_name          = "customerDocumentDeadLetterQueue-tf"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  dimensions = {
    QueueName = aws_sqs_queue.deadletter-customer-documents-queue.id
  }
  namespace                 = "AWS/SQS"
  period                    = "3600"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric monitors SQS Dead Letter Queue > 0"
  insufficient_data_actions = []
  tags                      = var.tags
  alarm_actions             = [data.aws_sns_topic.sawyerbrink-support.arn]
}