resource "aws_batch_compute_environment" "batch-compute-environment" {
  compute_environment_name = "${var.name}-risk-sensing-compute-tf"
  type                     = var.batch-type
  state                    = var.batch-state
  service_role             = aws_iam_role.aws_batch_service_role.arn

  compute_resources {
    max_vcpus = var.batch-max-cpus

    security_group_ids = data.aws_security_groups.sb-list.ids
    subnets            = data.aws_subnet_ids.sb-vpc.ids

    type = var.batch-compute-type
  }

  tags = merge({ Name = "${var.name}-risk-sensing-compute-tf" }, var.tags)

  depends_on = [aws_iam_role.aws_batch_service_role, aws_iam_role.ecs_instance_role]
}

resource "aws_batch_job_queue" "batch-compute-queue" {
  name     = "${var.name}-risk-sensing-compute-tf-job-queue"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.batch-compute-environment.arn
  ]
  tags = merge({ Name = "${var.name}-risk-sensing-compute-tf-job-queue" }, var.tags)
}

resource "aws_batch_job_definition" "batch-compute-job-definition" {
  name = "${var.name}-risk-sensing-compute-tf-job-definition"
  type = "container"

  platform_capabilities = var.batch-compute-type == "FARGATE_SPOT" ? ["FARGATE"] : []

  tags = merge({ Name = "${var.name}-risk-sensing-compute-tf-job-definition" }, var.tags)

  retry_strategy {
    attempts = var.batch-retry-attempts
  }

  timeout {
    attempt_duration_seconds = 60
  }

  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["sh", "-c", "./start.sh" ],
    "image": "${local.image}",
    "fargatePlatformConfiguration": {
         "platformVersion": "${var.fargate-version}"
    },
    "readonlyRootFilesystem": false,
    "environment": [
        {
          "name": "NEWSLIT_API_KEY", "value": "${data.aws_ssm_parameter.newslit-api-key.value}"
        },
        {
          "name": "TABLE", "value": "${aws_dynamodb_table.organization-table.id}"
        },
        {
          "name": "DEBUG", "value": "${false}"
        },
        {
          "name": "SNS_ARN", "value": "${data.aws_sns_topic.sawyerbrink-support.arn}"
        },
        {
          "name": "RDS_CLUSTER", "value": "${aws_rds_cluster.postgresql-rds.cluster_identifier}"
        },
         {
          "name": "AWS_DEFAULT_REGION", "value": "${var.region}"
        },
        {
          "name": "DB_USER", "value": "${var.rds-read-role}"
        },
        {
          "name": "DB_HOST", "value": "${aws_rds_cluster.postgresql-rds.endpoint}"
        },
        {
          "name": "DB_NAME", "value": "${var.rds-db-name}"
        },
        {
          "name": "DB_PORT", "value": "${var.rds-db-port}"
        },
         {
          "name": "ENVIRONMENT", "value": "${var.environment}"
        }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {},
         "secretOptions": []
    },
    "networkMode": "awsvpc",
    "secrets": [],
    "networkConfiguration": {
      "assignPublicIp": "ENABLED"
    },
    "resourceRequirements": [
      {
          "value": "${var.batch-cpu}",
          "type": "VCPU"
      },
      {
          "value": "${var.batch-memory}",
          "type": "MEMORY"
      }
    ],
    "executionRoleArn": "${aws_iam_role.aws_ecs_task_role.arn}",
    "jobRoleArn": "${aws_iam_role.aws_ecs_task_role.arn}",
    "propagateTags": "${true}"
}
CONTAINER_PROPERTIES
}
