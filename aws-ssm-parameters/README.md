# AWS SSM Parameter Terraform Module

This module provisions AWS SSM Parameters using Cloud Posse conventions. It supports parameter name composition from environment, region, and user-provided service/resource values, and enforces naming and value patterns.

## Features
- Composes SSM parameter names from environment, region, and user-provided values
- Enforces allowed patterns and segment validation
- Supports SecureString and KMS encryption
- Outputs parameter names, ARNs, and versions

## Usage

### 1. Define Defaults (components/terraform/ssm-parameters/defaults.yaml)
```yaml
vars:
  parameter_write_defaults:
    description: "Default description for all parameters"
    type: "SecureString"
    tier: "Standard"
    overwrite: true
    allowed_pattern: "^/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+/[a-z0-9]+$"
    data_type: "text"
  region: "us-east-1"
  tld: "dww"
  tenant: "dev"
  account: "data"
  region_naming_convention: "to_short"
  kms_arn: ""
```

### 2. Pass User Inputs in Stack (stacks/dev/us-east-1.yaml)
```yaml
components:
  terraform:
    ssm-parameters:
      vars:
        parameter_write:
          - service: "app"
            resource_type: "database"
            resource_name: "main"
            value: "db-connection-string"
          - service: "api"
            resource_type: "cache"
            resource_name: "redis"
            value: "redis-endpoint"
          - service: "web"
            resource_type: "config"
            resource_name: "settings"
            value: "web-settings"
```

### 3. Run with Atmos
```sh
atmos terraform plan ssm-parameters -s dev/us-east-1
atmos terraform apply ssm-parameters -s dev/us-east-1
```

## Outputs
- `ssm_parameter_names`: List of all SSM parameter names created
- `ssm_parameter_arns`: List of all SSM parameter ARNs created
- `ssm_parameter_versions`: Map of parameter names to their versions

## Requirements
- Terraform >= 1.2
- AWS provider
- [Cloud Posse Atmos](https://github.com/cloudposse/atmos) for stack/component management

## Example Parameter Name Structure
```
/dww/dev/data/us-east-1/app/database/main
```

## License
MIT
