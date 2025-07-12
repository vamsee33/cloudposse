variable "parameter_write_defaults" {
  type        = map(any)
  description = "Parameter write default settings"
  default = {
    description     = null
    type            = "SecureString"
    tier            = "Standard"
    overwrite       = "false"
    allowed_pattern = "^/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+$"
    data_type       = "text"
  }
}

variable "kms_arn" {
  type        = string
  default     = ""
  description = "KMS Key ARN to use for SecureString parameters. If not provided, the default AWS KMS key for SSM will be used."
}

variable "parameter_write" {
  type = list(object({
    service        = string
    resource_type  = string
    resource_name  = string
    value          = optional(string, "")
  }))
  default = []

  validation {
    condition     = alltrue([for p in var.parameter_write : can(regex("^[a-z0-9-]+$", p.service))])
    error_message = "Service must contain only lowercase letters, numbers, or hyphens."
  }
  validation {
    condition     = alltrue([for p in var.parameter_write : can(regex("^[a-z0-9-]+$", p.resource_type))])
    error_message = "Resource type must contain only lowercase letters, numbers, or hyphens."
  }
  validation {
    condition     = alltrue([for p in var.parameter_write : can(regex("^[a-z0-9-]+$", p.resource_name))])
    error_message = "Resource name must contain only lowercase letters, numbers, or hyphens."
  }
}

variable "region" {
  type        = string
  default     = ""
  description = "AWS region to use. If empty, will use module.this.region."
}

variable "tld" {
  type        = string
  default     = ""
  description = "Top-level domain or namespace. If empty, will use module.this.namespace."
}

variable "tenant" {
  type        = string
  default     = ""
  description = "Tenant identifier. If empty, will use module.this.tenant."
}

variable "account" {
  type        = string
  default     = ""
  description = "Account or stage identifier. If empty, will use module.this.stage."
}

variable "region_naming_convention" {
  type        = string
  default     = "to_short"
  description = "Naming convention for region codes."
}