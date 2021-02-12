# terraform

Folder contains terraform files for environment (subscription) [`Microsoft`](#microsoft) and reusable [Modules](#modules).
Following [Automate Terraform with GitHub Actions](https://learn.hashicorp.com/tutorials/terraform/github-actions).

Terraform must be setup using: [`setup.sh`](../hack/setup.sh)

```bash
az login

chmod +x ./hack/login.sh
chmod +x ./hack/variables.sh
chmod +x ./hack/secrets.sh
chmod +x ./hack/setup.sh

# Source the variables
source ./hack/variables.sh

# Create the initial environment
./hack/setup.sh

# Get the secrets for the SPN
source ./hack/secrets.sh
# printenv | grep ARM_ # ATTENTION: Potentially leaks secrets

# Login with the SPN
./hack/login.sh

# ____ following will run in the pipline ____

# Run Terraform
cd ./terraform/Microsoft

# Run terraform init with backend-config
./init.sh

terraform plan

terraform apply
```

See [`variables.sh`](../hack/variables.sh) and [`setup.sh`](../hack/setup.sh).

## Microsoft

Demo subscription that contains folders for each resource group.
Each resource group implements a `azurerm_resource_group` and a `random_id`, as well as one or more modules.

```terraform
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}
```

The [`inith.sh`](./Microsoft/init.sh) will setup the terraform using the `backend-config` provided by [variables.sh](../hack/variables.sh). This could be improved using a `.tfvars` file, but you run into Chicken or the Egg problems.

### Resource Groups

The subscription contains a bunch of resources groups.

| Resource Group | Description |
| -- | -- |
| `markwarnekeme-vnet` | Contains the basic networking for resources  |
| `markwarnekeme-shared` | Contains shared services, e.g. Log Analytics Workspaces, Container Registries, Central Service Bus & a shared Key Vault|
| `load-more` | Application workload based on Kubernetes |

## Modules

Contains a list of modules that can be reused in each subscription.

```terraform
module "log_analytics_workspace" {
  source = "../../Modules/log_analytics_workspace"

  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  tags                = local.tags
}
```

Each module contains a `test` folder. See [Modules](Modules).
