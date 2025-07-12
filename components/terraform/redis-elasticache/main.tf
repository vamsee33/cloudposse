provider "aws" {
  region = var.region
}

# Secure, serverless Redis cluster using outputs from a separate VPC component
module "redis" {
  source = "cloudposse/redis-serverless/aws"

  serverless_enabled                  = var.serverless_enabled
  zone_id                             = var.zone_id
  vpc_id                              = var.vpc_id
  allowed_security_groups             = var.allowed_security_groups
  subnets                             = var.subnet_ids
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
