##############################################
# Log Aggregation Event Rule
##############################################
resource "aws_cloudwatch_event_rule" "log-aggregator" {
  name                = "24hr-log-summary"
  description         = "Generates a daily log summary for each customer"
  is_enabled          = true
  role_arn            = var.cloudwatch-trigger-role-arn
  schedule_expression = var.log-aggregator-cron-rule
}

resource "aws_cloudwatch_event_target" "cloudwatch-event-lambda-target" {
  target_id = "24yr-logging-automation"
  rule      = aws_cloudwatch_event_rule.log-aggregator.name
  arn       = aws_lambda_alias.log-aggregator-lambda-alias.arn
}


resource "aws_cloudwatch_event_rule" "batch-trigger" {
  name        = "risk-sensing-trigger-morning"
  description = "Triggers the risk sensing batch job"
  is_enabled  = true
  role_arn    = var.cloudwatch-trigger-role-arn


  schedule_expression = var.batch-trigger-cron-rule
}

resource "aws_cloudwatch_event_target" "cloudwatch-event-batch-lambda-target" {
  target_id = "batch-trigger"
  rule      = aws_cloudwatch_event_rule.batch-trigger.name
  arn       = aws_lambda_alias.trigger-aws-batch-lambda-alias.arn
}


