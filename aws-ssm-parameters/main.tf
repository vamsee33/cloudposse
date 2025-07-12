resource "aws_ssm_parameter" "default" {
  for_each        = local.parameter_write != {} ? local.parameter_write : {}
  name            = each.key
  description     = each.value.description
  type            = each.value.type
  tier            = each.value.tier
  key_id          = each.value.type == "SecureString" && length(var.kms_arn) > 0 ? var.kms_arn : ""
  value           = each.value.value
  overwrite       = each.value.overwrite
  allowed_pattern = each.value.allowed_pattern
  data_type       = each.value.data_type
  tags            = module.this.tags
  lifecycle {
    precondition {
      condition     = can(regex("^/[a-z0-9]+(/[a-z0-9]+){5}$", each.key))
      error_message = "The SSM parameter name (each.key) must have exactly 6 segments separated by slashes and only contain lowercase letters and numbers."
    }
  }
}

module "utils" {
  source  = "cloudposse/utils/aws"
  version = "1.3.0"
  enabled = module.this.enabled
}
