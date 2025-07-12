output "ssm_parameter_names" {
  description = "List of all SSM parameter names created by this module."
  value       = [for k in aws_ssm_parameter.default : k.name]
}

output "ssm_parameter_arns" {
  description = "List of all SSM parameter ARNs created by this module."
  value       = [for k in aws_ssm_parameter.default : k.arn]
}

output "ssm_parameter_versions" {
  description = "Map of SSM parameter names to their versions."
  value       = { for k, v in aws_ssm_parameter.default : k => v.version }
}
