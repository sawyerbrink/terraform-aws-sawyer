module "backend-infra" {
  source                             = "../"
  profile                            = var.profile
  region                             = var.region
  name                               = var.name
  backendinfra-api-name              = var.backendinfra-api-name
  backendinfra-api-description       = var.backendinfra-api-description
  backendinfra-api-stage-auto-deploy = var.backendinfra-api-stage-auto-deploy
  backendinfra-api-domain-name       = var.backendinfra-api-domain-name
  backendinfra-api-stage-name        = var.backendinfra-api-stage-name
  backendinfra-security-policy       = var.backendinfra-security-policy
  backendinfra-api-version           = var.backendinfra-api-version
  backendinfra-environment           = var.backendinfra-environment
  backendinfra-api-certificate-arn = aws_acm_certificate.api-cert.arn
  backendinfra-cors-expose-headers   = var.backendinfra-cors-expose-headers
  logs-retention                     = var.logs-retention

  backendinfra-domain-name           = var.backendinfra-domain-name
  newslit-api-key = var.newslit-api-key

  lambda-repository-region          = var.lambda-repository-region
  backendinfra-iam-kms-grant-policy = ""
  kms-key-arn                       = module.kms-key.kms-key-arn
  backendinfra-support-sns-topic    = aws_sns_topic.sawyerbrink_support.arn
  backendinfra-vpc-id               = module.vpc.vpc_id
  backendinfra-private-subnet-ids   = module.vpc.private_subnets
  backendinfra-db-subnets-ids       = module.vpc.database_subnets

  backendinfra-security-group-ids = [
    module.vpc.default_security_group_id
  ]

  depends_on = [
    module.kms-key,
    module.vpc
  ]

  tags = var.tags
}


module "kms-key" {
  source  = "app.terraform.io/SawyerBrink/kms-key/aws"
  version = "1.0.3"

  allowed-key-users  = [data.aws_iam_role.admin-role.arn]
  aws-account-number = data.aws_caller_identity.current.id
  aws-services-approved = [
    "s3.amazonaws.com",
    "events.amazonaws.com",
    "cloudwatch.amazonaws.com",
    "sns.amazonaws.com",
    "logs.amazonaws.com",
    "delivery.logs.amazonaws.com",
    "autoscaling.amazonaws.com",
    "ec2.amazonaws.com"
  ]
  iam-policy-name        = "sb-kms-allow-demo"
  key-administrators-arn = [data.aws_iam_role.admin-role.arn]
  key-description        = "Account Main Key"
  key-usage              = "ENCRYPT_DECRYPT"
  kms-delete-window      = 7
  region                 = var.region
  tags                   = {}
  env                    = "test"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  enable_dns_hostnames = true
  enable_dns_support   = true
}