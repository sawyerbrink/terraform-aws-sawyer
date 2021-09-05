resource "aws_sns_topic" "sawyerbrink_support" {
  name              = "sawyerbrink-support"
  kms_master_key_id = module.kms-key.kms-key-id
}

resource "aws_sns_topic_policy" "sns_support_policy" {
  arn = aws_sns_topic.sawyerbrink_support.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.sawyerbrink_support.arn
    ]
  }
  statement {
    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "cloudwatch.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }

    resources = ["*"]

    sid = "__default_statement_ID"
  }
}

# resource "aws_sns_topic_subscription" "associate-slack-lambda" {
#   topic_arn = aws_sns_topic.sawyerbrink_support.arn
#   protocol  = "lambda"
#   endpoint  = aws_lambda_function.slack-lambda.arn
# }