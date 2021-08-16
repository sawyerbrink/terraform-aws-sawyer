resource "aws_cloudwatch_log_group" "APIGateway-log-group" {
  name              = "SawyerBrinkAPI-logs"
  retention_in_days = 1
  kms_key_id        = data.aws_kms_key.main-key-alias.arn
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
  alarm_actions             = [data.aws_sns_topic.sawyerbrink-support.arn]
}

resource "aws_cloudwatch_log_group" "aws_batch" {
  name              = "/aws/batch/job"
  retention_in_days = 1
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
  alarm_actions             = [data.aws_sns_topic.sawyerbrink-support.arn]
}