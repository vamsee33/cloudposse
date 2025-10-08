
````markdown
# Azure AD Application and Service Principal Terraform Module

## Overview

This Terraform module creates Azure AD Applications, Service Principals, and associated configurations **without requiring admin consent** permissions.

### 📌 Why this module?

The existing module includes admin-level permissions and is used by several workloads. This creates potential security and compliance issues due to **excessive permissions**.

To mitigate this risk, we've created this new module that:
- **Excludes admin consent** resources.
- Focuses on **least-privilege** access.
- Is designed to support workloads that do **not require elevated permissions**.

> ⚠️ If your application **requires admin consent** (e.g., `Application.ReadWrite.All`), please use the existing `application_service_principals` module.

---

## Features

This module provides the following:
- Azure AD Application and Service Principal creation.
- Federated credentials for GitHub OIDC login.
- Automatic App secret rotation and storage in Azure Key Vault.
- Least-privilege Microsoft Graph permissions (e.g., `User.Read`, `Directory.Read.All`).
- Regional Key Vault configuration and access control.
- Outputs for application and service principal IDs.

---

## Resources Created

- `azuread_application` (main and GitHub apps)
- `azuread_service_principal`
- `azuread_application_federated_identity_credential`
- `azuread_application_password`
- `azurerm_key_vault` (for WUS3 and EUS)
- `azurerm_key_vault_secret` (for App ID and Secret)
- `azurerm_key_vault_access_policy`
- Timers for secret rotation and deployment wait

---

## Usage

```hcl
module "aad_app" {
  source = "./this-module-path"

  app_id                         = "a99999"
  application_name               = "myapp"
  environment                    = "dev"
  github_repo_name               = "AzureWorkload_A99999"
  application_github_repo_environment = "DEV"
  deployment_cilent_id           = "cc5198ae-6c2c-4c01-8ebc-f5c8c5bbb351"
  ...
}
````

### Optional Inputs

* `default_resource_access`: Boolean to toggle default permissions.
* `resources_access_list`: Provide custom Graph API permissions.
* `rotation_days`: App secret rotation interval (default `6` days).
* `idvault`: Use empty string when creating a new SPN.

---

## Outputs

| Name                                   | Description                          |
| -------------------------------------- | ------------------------------------ |
| `application_id`                       | Azure AD Application (Client) ID     |
| `object_id`                            | Azure AD Service Principal Object ID |
| `resource_service_principal_object_id` | Microsoft Graph Service Principal ID |

---

## Limitations

* This module **does not** perform admin consent operations.
* Ensure the deployment client has required permissions to create AAD resources and Key Vault policies.

---

## Contributing

If your workload requires elevated permissions, fork this module and integrate with admin-consent handling in a secure and auditable way.

---
```
