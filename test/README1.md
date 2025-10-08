
````markdown
# Azure AD Application Registration with Secret Rotation

This Terraform module creates an **Azure Active Directory (Azure AD) Application Registration**, including:

- Service Principal
- Client secret with automated rotation
- Secure storage of the secret and application ID in **Azure Key Vault**
- Optional support for multiple regions (e.g., WUS3 and EUS)
- Integration with **Microsoft Graph** permissions via `required_resource_access`

## ⚠️ Version Notice

> **NOTE:** This module currently uses a **version constraint with an older `azuread` provider version `2.19.1`** due to compatibility and stability concerns.  
> Please **continue to use this version** until we explicitly agree to upgrade to the latest version.

## Providers and Versions

```hcl
terraform {
  required_version = "= 1.1.7"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.19.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}
````

## Features

* Creates an Azure AD Application with configurable `required_resource_access`
* Creates a Service Principal
* Creates a client secret using `azuread_application_password`
* Secret rotation using `time_rotating`
* Stores secret and client ID in Azure Key Vault (supporting multiple regions)
* Outputs useful application and SPN identifiers

## Variables

| Name                       | Description                                          | Type   | Default    |
| -------------------------- | ---------------------------------------------------- | ------ | ---------- |
| `app_id`                   | The application ID prefix                            | string | `"a99999"` |
| `app_name`                 | The name of the application                          | string | `""`       |
| `environment`              | The environment suffix (e.g., `dev`, `prod`)         | string | `"dev"`    |
| `key_vault_id_w3`          | Key Vault ID for WUS3 region                         | string | —          |
| `key_vault_id_eus`         | Key Vault ID for EUS region                          | string | `null`     |
| `eus_enabled`              | Whether to store secrets in EUS as well              | bool   | `true`     |
| `required_resource_access` | Microsoft Graph or other API permissions for the app | list   | Predefined |

## Outputs

| Name                                   | Description                                |
| -------------------------------------- | ------------------------------------------ |
| `application_id`                       | The Client ID of the Azure AD application  |
| `object_id`                            | Object ID of the created Service Principal |
| `resource_service_principal_object_id` | Object ID for Microsoft Graph SPN          |

## Usage Example

```hcl
module "aad_app" {
  source              = "./path-to-module"
  app_id              = "a12345"
  app_name            = "my-app"
  environment         = "prod"
  key_vault_id_w3     = azurerm_key_vault.kv_wus3.id
  key_vault_id_eus    = azurerm_key_vault.kv_eus.id
  eus_enabled         = true

  required_resource_access = [
    {
      resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
      resource_access = [
        { id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d", type = "Scope" }, # User.Read
        { id = "18a4783c-866b-4cc7-a460-3d5e5662c884", type = "Scope" }  # AppRoleAssignment.ReadWrite.All
      ]
    }
  ]
}
```

## Notes

* The client secret is rotated every **360 days**
* Secrets stored in Key Vault expire after **360 days**
* Microsoft Graph Service Principal is reused via `azuread_application_published_app_ids`

## Future Plans

* Upgrade to latest `azuread` provider when stability and compatibility are verified
* Support for managed identity or certificate-based credentials (optional)

---

Let me know if you’d like to also generate a `main.tf`, `variables.tf`, and `outputs.tf` split from your monolithic file for module use.
```
