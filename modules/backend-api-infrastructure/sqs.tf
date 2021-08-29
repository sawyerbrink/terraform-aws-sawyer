resource "aws_sqs_queue" "audit-queue" {
  name                       = "audit-queue"
  delay_seconds              = 0
  max_message_size           = 262144
  visibility_timeout_seconds = 35
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 20
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter-audit-queue.arn
    maxReceiveCount     = 1
  })
  kms_master_key_id                 = var.kms-key-arn
  kms_data_key_reuse_period_seconds = 86400 // 24 hrs

  depends_on = [aws_sqs_queue.deadletter-audit-queue]
}

resource "aws_sqs_queue_policy" "audit-queue-policy" {
  queue_url = aws_sqs_queue.audit-queue.id

  policy = <<POLICY
{
  "Id": "Policy1601067010798",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1601066936762",
      "Action": [
        "sqs:SendMessage"
      ],
      "Effect": "Allow",
      "Resource": "${aws_sqs_queue.audit-queue.arn}",
      "Principal": {
        "AWS": [
          "${aws_iam_role.lambda-role.arn}"
        ]
      }
    },
    {
      "Sid": "Stmt1601067007732",
      "Action": [
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ReceiveMessage"
      ],
      "Effect": "Allow",
      "Resource": "${aws_sqs_queue.audit-queue.arn}",
      "Principal": {
        "AWS": [
          "${aws_iam_role.lambda-sqs-role.arn}"
        ]
      }
    }
  ]
}
POLICY

  depends_on = [aws_iam_role.lambda-sqs-role, aws_sqs_queue.audit-queue]
}



resource "aws_sqs_queue" "deadletter-audit-queue" {
  name                              = "deadletter-audit-queue"
  delay_seconds                     = 0
  max_message_size                  = 262144
  visibility_timeout_seconds        = 43200
  message_retention_seconds         = 1209600 // 14 days
  receive_wait_time_seconds         = 20
  kms_master_key_id                 = var.kms-key-arn
  kms_data_key_reuse_period_seconds = 86400 // 24 hrs
  tags                              = merge({ "IsDeadLetter" = true }, var.tags)
}

resource "aws_sqs_queue_policy" "deadletter-audit-policy" {
  queue_url = aws_sqs_queue.deadletter-audit-queue.id

  policy     = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "auditSQSPolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.deadletter-audit-queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.audit-queue.arn}"
        }
      }
    }
  ]
}
POLICY
  depends_on = [aws_sqs_queue.deadletter-audit-queue, aws_sqs_queue.audit-queue]
}
#####################################
# Customer Documents Queue
####################################
resource "aws_sqs_queue" "customer-documents-queue" {
  name                       = "customer-documents-queue"
  delay_seconds              = 0
  max_message_size           = 262144
  visibility_timeout_seconds = 43200
  message_retention_seconds  = 1209600 // 14 days
  receive_wait_time_seconds  = 20
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter-customer-documents-queue.arn
    maxReceiveCount     = 1
  })
  kms_master_key_id                 = var.kms-key-arn
  kms_data_key_reuse_period_seconds = 86400 // 24 hrs



  depends_on = [aws_sqs_queue.deadletter-customer-documents-queue]
}

resource "aws_sqs_queue_policy" "customer-documents-queue-policy" {
  queue_url = aws_sqs_queue.customer-documents-queue.id

  policy     = <<POLICY
{
  "Id": "Policy1602973201499",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1602973031296",
      "Action": [
        "sqs:SendMessage"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:*:*:customer-documents-queue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_s3_bucket.customers-documents.arn}"
        }
      },
      "Principal": "*"
    },
    {
      "Sid": "Stmt1602973200274",
      "Action": [
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ReceiveMessage"
      ],
      "Effect": "Allow",
      "Resource": "${aws_sqs_queue.customer-documents-queue.arn}",
      "Principal": {
        "AWS": [
          "${aws_iam_role.lambda-role.arn}"
        ]
      }
    }
  ]
}
POLICY
  depends_on = [aws_iam_role.lambda-role, aws_sqs_queue.customer-documents-queue, aws_s3_bucket.customers-documents]
}


resource "aws_sqs_queue" "deadletter-customer-documents-queue" {
  name                              = "deadletter-customer-documents-queue"
  delay_seconds                     = 0
  max_message_size                  = 262144
  visibility_timeout_seconds        = 45
  message_retention_seconds         = 14400
  receive_wait_time_seconds         = 20
  kms_master_key_id                 = var.kms-key-arn
  kms_data_key_reuse_period_seconds = 86400 // 24 hrs
  tags                              = merge({ "IsDeadLetter" = true }, var.tags)
}

resource "aws_sqs_queue_policy" "deadletter-customer-documents-queue-policy" {
  queue_url = aws_sqs_queue.deadletter-customer-documents-queue.id

  policy     = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "auditSQSPolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.deadletter-customer-documents-queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.customer-documents-queue.arn}"
        }
      }
    }
  ]
}
POLICY
  depends_on = [aws_sqs_queue.customer-documents-queue, aws_sqs_queue.customer-documents-queue]

}