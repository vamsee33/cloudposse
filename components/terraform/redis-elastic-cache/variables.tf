variable "region" {
  type        = string
  description = "AWS region"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zone IDs"
  default     = []
}

variable "multi_az_enabled" {
  type        = bool
  default     = false
  description = "Multi AZ (Automatic Failover must also be enabled.  If Cluster Mode is enabled, Multi AZ is on by default, and this setting is ignored)"
}

variable "family" {
  type        = string
  description = "Redis family"
}

variable "port" {
  type        = number
  description = "Port number"
  default     = null
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for permitted ingress"
  default     = []
}

variable "allow_all_egress" {
  type        = bool
  default     = true
  description = <<-EOT
    If `true`, the created security group will allow egress on all ports and protocols to all IP address.
    If this is false and no egress rules are otherwise specified, then no egress will be allowed.
    EOT
}

variable "at_rest_encryption_enabled" {
  type        = bool
  description = "Enable encryption at rest"
}

variable "transit_encryption_enabled" {
  type        = bool
  description = "Enable TLS"
}

variable "auth_token_enabled" {
  type        = bool
  description = "Enable auth token"
  default     = true
}

variable "apply_immediately" {
  type        = bool
  description = "Apply changes immediately"
}

variable "automatic_failover_enabled" {
  type        = bool
  description = "Enable automatic failover"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported if the engine version is 6 or higher."
  default     = false
}

variable "cloudwatch_metric_alarms_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable CloudWatch metrics alarms"
}

variable "redis_clusters" {
  type        = map(any)
  description = "Redis cluster configuration"
}

variable "allow_ingress_from_this_vpc" {
  type        = bool
  default     = true
  description = "If set to `true`, allow ingress from the VPC CIDR for this account"
}

variable "allow_ingress_from_vpc_stages" {
  type        = list(string)
  default     = []
  description = "List of stages to pull VPC ingress cidr and add to security group"
}

variable "eks_security_group_enabled" {
  type        = bool
  description = "Use the eks default security group"
  default     = false
}

variable "eks_component_names" {
  type        = set(string)
  description = "The names of the eks components"
  default     = []
}

variable "snapshot_retention_limit" {
  type        = number
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them."
  default     = 0
}

variable "serverless_enabled" {
  description = "Enable serverless mode for Redis."
  type        = bool
  default     = true
}

variable "serverless_major_engine_version" {
  description = "Major engine version for serverless Redis."
  type        = string
  default     = "7.0"
}

variable "serverless_cache_usage_limits" {
  description = "Usage limits for serverless Redis. List of objects with type, maximum, and unit."
  type        = list(object({
    type    = string
    maximum = number
    unit    = string
  }))
  default = [
    { type = "data_storage", maximum = 100, unit = "GB" },
    { type = "ecpu", maximum = 1000, unit = "ECU" }
  ]
}

variable "serverless_snapshot_arns_to_restore" {
  description = "List of snapshot ARNs to restore for serverless Redis."
  type        = list(string)
  default     = []
}

variable "multi_az_enabled" {
  description = "Enable Multi-AZ for Redis."
  type        = bool
  default     = true
}

variable "allow_all_egress" {
  description = "Allow all egress traffic from Redis."
  type        = bool
  default     = true
}

variable "maintenance_window" {
  description = "Preferred maintenance window for Redis."
  type        = string
  default     = null
}

variable "snapshot_window" {
  description = "Preferred snapshot window for Redis."
  type        = string
  default     = null
}

variable "snapshot_retention_limit" {
  description = "Number of days to retain automatic snapshots."
  type        = number
  default     = 7
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover for Redis."
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades for Redis."
  type        = bool
  default     = true
}

variable "cloudwatch_metric_alarms_enabled" {
  description = "Enable CloudWatch metric alarms for Redis."
  type        = bool
  default     = false
}

variable "auth_token_enabled" {
  description = "Enable AUTH token for Redis."
  type        = bool
  default     = false
}
