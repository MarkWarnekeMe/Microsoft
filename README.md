# Microsoft

Microsoft a287d458-0ab8-4a73-9ca6-6f44345f1ada

## Getting started

```bash
az login

chmod +x ./hack/login.sh
chmod +x ./hack/variables.sh
chmod +x ./hack/secrets.sh
chmod +x ./hack/setup.sh

source ./hack/variables.sh
./hack/setup.sh
source ./hack/secrets.sh
# printenv | grep ARM_ # ATTENTION: Potentially leaks secrets

cd ./terraform/Microsoft
./init.sh
./plan.sh
```

## variables.sh

Sources the configuration variables.

```bash
source ./hack/variables.sh
```

| Variable Name       | Description                                                                                                                                                                |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `subscription_id`   | Used to set the current subscription in `setup.sh`                                                                                                                         |
| `connection_name`   | Name of the automation Service Principal                                                                                                                                   |
| `resource_name`     | Name of the initial resources created by `setup.py`, later also used as a variable for the terraform backend initialization in `init.sh` via `TF_VAR_storage_account_name` |
| `resource_location` | Same as `resource_name`                                                                                                                                                    |
| `container_name`    | Same as `resource_name`                                                                                                                                                    |


## login.sh

runs `az login --service-principal` given the variables from `variables.sh`.

## setup.sh

Source the variables first `source ./hack/variables.sh`.
Make sure `jq` is installed (`brew install jq`).

1. Sets current subscription based on `subscription_id`
2. Create a service principal
   1. for executing Github Actions and
   2. Terraform [authenticating using a Service Principal with a Client Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
3. Create a initial resource group
4. Create a initial storage account & container
5. Create a initial key vault
6. Add get, list and set secrets permissions on key vault for service principal
7. Set the service principal output details in key vault to [configuring the Service Principal in Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#configuring-the-service-principal-in-terraform) later. Each secret is named `$connection_name-<JSON_OUTPUT>`, e.g. `markwarnekeme-clientId`, see below JSON for reference.

```JSON
{
   "clientId": "<clientId>",
   "clientSecret": "<clientSecret>",
   "subscriptionId": "<subscriptionId>",
   "tenantId": "<tenantId>",
   "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
   "resourceManagerEndpointUrl": "https://management.azure.com/",
   "activeDirectoryGraphResourceId": "https://graph.windows.net/",
   "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
   "galleryEndpointUrl": "https://gallery.azure.com/",
   "managementEndpointUrl": "https://management.core.windows.net/"
}
```

Uses `jq -r <JSON_PROPERTY>` to save the values. e.g. to store the `clientId`.

```bash
clientId=$(echo $spn | jq -r '.clientId') #
```

## secrets.sh

After the setup is done successfully. The stored secrets can be fetched using `secrets.sh`, make sure to be signed in using the SPN.
This setp is necessary to [authenticating using a Service Principal with a Client Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) for Terraform.

```bash
source ./hack/variables.sh
source ./hack/secrets.sh
```

The script outputs it like:

```bash
$ export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
$ export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
$ export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
$ export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
```

## terraform.yaml

Following [Automate Terraform with GitHub Actions](https://learn.hashicorp.com/tutorials/terraform/github-actions).

![](https://learn.hashicorp.com/img/terraform/automation/tfc-gh-actions-workflow.png)


![](https://learn.hashicorp.com/img/terraform/automation/pr-master-gh-actions-workflow.png)