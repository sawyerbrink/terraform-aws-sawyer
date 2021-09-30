module "backend-infra" {

  source  = "sawyerbrink/sawyer/aws"
  version = "1.0.0"

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }


  profile                            = var.profile
  region                             = var.region
  dr-region                          = var.dr-region
  sawyer-version                     = var.sawyer-version
  name                               = var.name
  org-name                           = var.org-name
  org-email-domain                   = var.org-email-domain
  org-industry                       = var.org-industry
  org-size                           = var.org-size
  backendinfra-api-name              = var.backendinfra-api-name
  backendinfra-api-description       = var.backendinfra-api-description
  backendinfra-api-stage-auto-deploy = var.backendinfra-api-stage-auto-deploy
  backendinfra-api-domain-name       = var.backendinfra-api-domain-name
  backendinfra-api-stage-name        = var.backendinfra-api-stage-name
  backendinfra-security-policy       = var.backendinfra-security-policy
  backendinfra-batch-cpu             = var.backendinfra-batch-cpu
  backendinfra-batch-memory          = var.backendinfra-batch-memory
  backendinfra-api-version           = var.backendinfra-api-version
  backendinfra-environment           = var.backendinfra-environment
  backendinfra-api-certificate-arn   = aws_acm_certificate.api-cert.arn
  backendinfra-cors-expose-headers   = var.backendinfra-cors-expose-headers
  logs-retention                     = var.logs-retention

  backendinfra-domain-name = var.backendinfra-domain-name
  newslit-api-key          = var.newslit-api-key

  lambda-repository-region          = var.lambda-repository-region
  website-repository-region         = var.website-repository-region
  backendinfra-iam-kms-grant-policy = ""
  kms-key-arn                       = module.kms-key.kms-key-arn
  backendinfra-support-sns-topic    = aws_sns_topic.sawyerbrink_support.arn
  backendinfra-vpc-id               = module.vpc.vpc_id
  backendinfra-private-subnet-ids   = module.vpc.private_subnets
  backendinfra-db-subnets-ids       = module.vpc.database_subnets
  backendinfra-rds-db-subnet-name   = module.vpc.database_subnet_group_name
  backendinfra-rds-enable-public-ip = var.backendinfra-rds-enable-public-ip

  backendinfra-security-group-ids = [
    aws_security_group.public_allow_traffic.id
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

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets  = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  database_subnets = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]
  public_subnets   = ["10.0.192.0/19", "10.0.224.0/19"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_ipv6        = true

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true
  create_igw                             = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  database_subnet_group_name = "${var.name}-db-subnets"
}