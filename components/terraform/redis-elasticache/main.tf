provider "aws" {
  region = var.region
}

# Create VPC
module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.2.0"

  ipv4_primary_cidr_block = var.vpc_cidr_block
  context = module.this.context
}

# Create private subnets
module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.2"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  nat_gateway_enabled  = false
  nat_instance_enabled = false
  context = module.this.context
}

# Private Route53 zone for Redis
resource "aws_route53_zone" "private" {
  name = format("elasticache-redis-terratest-%s.testing.cloudposse.co", try(module.this.attributes[0], "default"))
  vpc {
    vpc_id = module.vpc.vpc_id
  }
}

# CloudWatch logs for Redis
module "cloudwatch_logs" {
  source  = "cloudposse/cloudwatch-logs/aws"
  version = "0.6.8"
  context = module.this.context
}

# Secure, serverless Redis cluster
module "redis" {
  source = "cloudposse/redis-serverless/aws"

  serverless_enabled                  = var.serverless_enabled
  zone_id                             = [aws_route53_zone.private.id]
  vpc_id                              = module.vpc.vpc_id
  allowed_security_groups             = [module.vpc.vpc_default_security_group_id]
  subnets                             = module.subnets.private_subnet_ids
  serverless_major_engine_version     = var.serverless_major_engine_version
  at_rest_encryption_enabled          = var.at_rest_encryption_enabled
  serverless_cache_usage_limits       = var.serverless_cache_usage_limits
  serverless_snapshot_arns_to_restore = var.serverless_snapshot_arns_to_restore
  security_group_create_before_destroy = true
  security_group_name                  = length(var.sg_name) > 0 ? [var.sg_name] : []
  security_group_delete_timeout        = "5m"
  # Optional Auth
  auth_token = var.auth_token
  # Disable public access
  publicly_accessible = false
  # Use AWS managed KMS key by default
  kms_key_id = var.kms_key_id
  context = module.this.context
}
