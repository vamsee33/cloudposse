output "redis_endpoint" {
  value       = module.redis_serverless.primary_endpoint_address
  description = "Redis primary endpoint"
}

output "redis_port" {
  value       = module.redis_serverless.port
  description = "Redis port"
}

output "security_group_id" {
  value       = module.sg_redis.security_group_id
  description = "Security group ID for Redis"
}
