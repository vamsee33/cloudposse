variable "databricks_cicd_policy_configuration" {
  type = object({
    enable_ssm_access              = optional(bool, false)
    enable_secretsmanager_access  = optional(bool, false)
  })
  default     = {}
  nullable    = false
  description = <<-EOT
    Configuration for the databricks-cicd policy. The following keys are supported:
      - `enable_ssm_access` - (bool) - Whether to allow access to SSM. Defaults to false.
      - `enable_secretsmanager_access` - (bool) - Whether to allow access to Secrets Manager. Defaults to false.
  EOT
}

locals {
  databricks_cicd_policy_enabled = contains(var.iam_policies, "databricks-cicd")
  databricks_cicd_policy         = local.databricks_cicd_policy_enabled ? one(data.aws_iam_policy_document.databricks_cicd_policy.*.json) : null
}

data "aws_iam_policy_document" "databricks_cicd_policy" {
  count = local.databricks_cicd_policy_enabled ? 1 : 0

  dynamic "statement" {
    for_each = lookup(var.databricks_cicd_policy_configuration, "enable_ssm_access", false) ? [1] : []
    content {
      effect = "Allow"
      actions = [
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath",
        "ssm:DescribeParameters"
      ]
      resources = [
        "*"
      ]
    }
  }

  dynamic "statement" {
    for_each = lookup(var.databricks_cicd_policy_configuration, "enable_secretsmanager_access", false) ? [1] : []
    content {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = [
        "*"
      ]
    }
  }
}
