# Microsoft ![Terraform](https://github.com/MarkWarnekeMe/Microsoft/workflows/Terraform/badge.svg?branch=main) ![Kubernetes](https://github.com/MarkWarnekeMe/Microsoft/workflows/Kubernetes/badge.svg?branch=main) ![Hack](https://github.com/MarkWarnekeMe/Microsoft/workflows/Hack/badge.svg?branch=main) ![Markdown](https://github.com/MarkWarnekeMe/Microsoft/workflows/Markdown/badge.svg?branch=main)

Terraform GitOps demo repository.
In this repository I am going to demonstrate how to use a GitOps approach to Terraform and Kubernetes.

You can review the CI/CD implementation in the [workflows](./workflows/) directory.
The scripts to setup the Terraform backend are located in [hack](../hack/).
Terraform templates for Resource Groups and reusable modules are located in [terraform](../terraform/).
Kubernetes GitOps configuration files are located in [clusters](../clusters/), Flux is used to provision Kubernetes manifests.

## Documentation

| File                       | Description              |
| -------------------------- | ------------------------ |
| [workflows](./workflows/)  | CI/CD documentation      |
| [hack](../hack/)           | Scripts documentation    |
| [terraform](../terraform/) | Terraform documentation  |
| [clusters](../clusters/)   | Kubernetes documentation |


## Getting started

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

# Run Terraform
cd ./terraform/Microsoft

# Run terraform init with backend-config
./init.sh

terraform plan

terraform apply
```
