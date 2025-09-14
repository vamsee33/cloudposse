# Azure Analysis Services (Terraform Module)

This Terraform module deploys an **Azure Analysis Services Server** with customizable SKU, admin users, Power BI integration, and firewall rules.

---

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.13 |
| azurerm   | >= 2.0  |

---

## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | >= 2.0  |

---

## Usage

```hcl
module "analysis_service" {
  source              = "../modules/analysis-service"
  for_each            = {
    for key, value in try(local.settings.analysis_services, {}) : key => value
    if try(value.enabled, false)
  }

  global_settings     = local.settings
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  analysis_service    = each.value
}
```

### Example `settings.yaml`

```yaml
analysis_services:
  analysis_server1:
    enabled: true
    name: "testanalysis01r02d"
    resource_group_key: "application"
    sku: "S0"
    admin_users:
      - "user@domain.com"
    ipv4_firewall_rule:
      rule1:
        name: "AllowCorp"
        range_start: "192.168.1.1"
        range_end: "192.168.1.255"
```

---

## Inputs

| Name                  | Description                                                     | Type       | Default | Required |
| --------------------- | --------------------------------------------------------------- | ---------- | ------- | :------: |
| `analysis_service`    | Configuration object for the Analysis Services server.          | `any`      | n/a     |    yes   |
| `global_settings`     | Global settings object (tags, defaults, etc).                   | `any`      | n/a     |    yes   |
| `location`            | Azure region to deploy the server. Defaults to global settings. | `string`   | `null`  |    no    |
| `resource_group_name` | Resource group where the server will be deployed.               | `string`   | n/a     |    yes   |
| `tags`                | Custom tags to apply (merged with global tags).                 | `map(any)` | `{}`    |    no    |

---

## Outputs

| Name              | Description                                    |
| ----------------- | ---------------------------------------------- |
| `server_name`     | Name of the deployed Analysis Services server. |
| `server_location` | Azure region where the server is deployed.     |
| `server_id`       | Resource ID of the Analysis Services server.   |

---

## Notes on Azure Analysis Services

1. **SKU Considerations**
   Available SKUs include `D1`, `S0`, `S1`, `S2`, and higher. Choose based on memory and query requirements.

2. **Admin Users**
   Must specify at least one Azure AD user or group for server administration. Required for access.

3. **Power BI Integration**
   Enabled by default (`enable_power_bi_service = true`). Disable only if Power BI connectivity is not needed.

---

## Region and Availability Constraints

Azure Analysis Services is available only in selected regions. Common supported regions include:

* East US
* West Europe
* Southeast Asia

You can verify regional availability at:

[Azure Products by Region](https://azure.microsoft.com/en-us/global-infrastructure/services/)

> If a region is not supported, Terraform will fail during resource creation.

---

## Additional Resources

* [Terraform Registry - azurerm\_analysis\_services\_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/analysis_services_server)
* [Microsoft Docs - Azure Analysis Services](https://learn.microsoft.com/en-us/azure/analysis-services/)
* [Azure Service Availability by Region](https://azure.microsoft.com/en-us/explore/global-infrastructure/products-by-region/)


