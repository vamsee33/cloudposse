provider "aws" {
  region = var.region
}

module "redis_serverless" {
  source  = "cloudposse/redis-serverless/aws"

  name                              = var.name
  region                            = var.region
  vpc_id                            = var.vpc_id
  subnets                           = var.subnet_ids
  allowed_security_groups           = var.allowed_security_groups
  zone_id                           = var.zone_id
  serverless_enabled                = true
  serverless_major_engine_version   = var.serverless_major_engine_version
  at_rest_encryption_enabled        = var.at_rest_encryption_enabled
  serverless_cache_usage_limits     = var.serverless_cache_usage_limits
  serverless_snapshot_arns_to_restore = var.serverless_snapshot_arns_to_restore
  security_group_create_before_destroy = true
  security_group_name               = length(var.sg_name) > 0 ? [var.sg_name] : []
  security_group_delete_timeout     = "5m"
  auth_token                       = var.auth_token
  publicly_accessible               = false
  kms_key_id                        = var.kms_key_id
  context                           = module.this.context
}
