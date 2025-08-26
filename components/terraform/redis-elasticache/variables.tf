variable "name" {
  description = "Name for the Redis cluster"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the cluster"
  type        = list(string)
}

variable "kms_key_id" {
  description = "KMS Key ID for encryption"
  type        = string
  default     = null
}

variable "auth_token" {
  description = "Auth token for Redis AUTH (optional)"
  type        = string
  default     = null
}

variable "parameter_group_name" {
  description = "Custom parameter group name"
  type        = string
  default     = null
}

variable "sg_rules" {
  description = "Security group rules for Redis"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr_block" {
  description = "Primary CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "serverless_enabled" {
  description = "Enable serverless Redis"
  type        = bool
  default     = true
}

variable "serverless_major_engine_version" {
  description = "Redis serverless major engine version"
  type        = string
  default     = "7.0"
}

variable "at_rest_encryption_enabled" {
  description = "Enable at-rest encryption"
  type        = bool
  default     = true
}

variable "serverless_cache_usage_limits" {
  description = "Usage limits for serverless Redis"
  type        = list(any)
  default     = [
    { data_storage = { maximum = 100, unit = "GB" } },
    { ecpu = { maximum = 1000, unit = "ECU" } }
  ]
}

variable "serverless_snapshot_arns_to_restore" {
  description = "List of snapshot ARNs to restore for serverless Redis"
  type        = list(string)
  default     = []
}

variable "sg_name" {
  description = "Name for the Redis security group"
  type        = string
  default     = "redis-serverless-sg"
}

variable "auth_token" {
  description = "Auth token for Redis AUTH (optional)"
  type        = string
  default     = "mySuperSecretToken"
}

variable "kms_key_id" {
  description = "KMS Key ID for encryption"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "myapp"
  }
}
