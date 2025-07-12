
locals {
  region = var.region != "" ? var.region : module.this.region
  tld = var.tld != "" ? var.tld : module.this.namespace
  tenant = var.tenant != "" ? var.tenant : module.this.tenant
  account = var.account != "" ? var.account : module.this.stage
  region_short = module.utils.region_az_alt_code_maps[var.region_naming_convention][local.region]
}


#locals {
#  enabled = module.this.enabled
#  parameter_write = local.enabled ? {
#    for p in var.parameter_write :
#    format("/%s/%s/%s/%s/%s/%s", local.tld, local.tenant, local.account, local.region, p.service, p.resource_type, p.resource_name) => merge(var.parameter_write_defaults, {
#      value         = p.value
#      service       = p.service
#      resource_type = p.resource_type
#      resource_name = p.resource_name
#    })
#  } : {}
#}

locals {
  enabled = module.this.enabled
  parameter_write = local.enabled ? {
    for p in var.parameter_write :
    join("/", [
      "",
      local.tld,
      local.tenant,
      local.account,
      local.region,
      p.service,
      p.resource_type,
      p.resource_name
    ]) => merge(var.parameter_write_defaults, {
      value         = p.value
      service       = p.service
      resource_type = p.resource_type
      resource_name = p.resource_name
    })
  } : {}
}
