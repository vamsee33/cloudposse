# Redis Serverless (ElastiCache) Cloud Posse Component

This component deploys a secure, serverless AWS ElastiCache Redis cluster using Cloud Posse best practices.

## Features
- Serverless Redis (ElastiCache)
- Multi-AZ, 1-region, 1-cluster by default
- Optional Redis AUTH token
- Isolated via Security Group (no public access)
- At-rest and in-transit encryption (AWS managed KMS)
- All settings parameterized

## Default Values (components/terraform/redis-serverless/defaults.yaml)
```yaml
vars:
  region: us-east-1
  vpc_cidr_block: "172.16.0.0/16"
  availability_zones:
    - us-east-1a
    - us-east-1b
    - us-east-1c
  serverless_enabled: true
  serverless_major_engine_version: "7.0"
  at_rest_encryption_enabled: true
  serverless_cache_usage_limits:
    - data_storage:
        maximum: 100
        unit: "GB"
    - ecpu:
        maximum: 1000
        unit: "ECU"
  serverless_snapshot_arns_to_restore: []
  sg_name: "redis-serverless-sg"
  auth_token: "mySuperSecretToken"
  kms_key_id: null
  tags:
    Environment: "dev"
    Project: "myapp"
```

## Example Atmos Stack (stacks/dev/us-east-1.yaml)
```yaml
components:
  terraform:
    redis-serverless:
      vars:
        region: us-east-1
        vpc_cidr_block: "172.16.0.0/16"
        availability_zones:
          - us-east-1a
          - us-east-1b
          - us-east-1c
        serverless_enabled: true
        serverless_major_engine_version: "7.0"
        at_rest_encryption_enabled: true
        serverless_cache_usage_limits:
          - data_storage:
              maximum: 100
              unit: "GB"
          - ecpu:
              maximum: 1000
              unit: "ECU"
        serverless_snapshot_arns_to_restore: []
        sg_name: "redis-serverless-sg"
        auth_token: "mySuperSecretToken"
        kms_key_id: null
        tags:
          Environment: "dev"
          Project: "myapp"
```

## Outputs
- `redis_endpoint` – Redis primary endpoint
- `redis_port` – Redis port
- `security_group_id` – Security group ID

## Requirements
- Terraform >= 1.2
- AWS provider
- [Cloud Posse Atmos](https://github.com/cloudposse/atmos) for stack/component management

## License
MIT
