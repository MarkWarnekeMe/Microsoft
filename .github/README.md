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

Review the [variables.sh](https://github.com/MarkWarnekeMe/Microsoft/blob/main/hack/variables.sh) script and run the [setup.sh](https://github.com/MarkWarnekeMe/Microsoft/blob/main/hack/setup.sh)

```sh
az login

chmod +x ./hack/login.sh
chmod +x ./hack/variables.sh
chmod +x ./hack/secrets.sh
chmod +x ./hack/setup.sh

# Source the variables
source ./hack/variables.sh

# Create the initial environment
./hack/setup.sh
```

Make sure the pipeline is configured correctly, create `AZURE_CREDENTIALS` inside of the GitHub action using the service principal created.
After kubernetes is setup run [flux.sh](https://github.com/MarkWarnekeMe/Microsoft/blob/main/hack/flux.sh), create a [Personal access tokens](https://github.com/settings/tokens/new) via `Settings/Developer settings/Personal access tokens`

```
# Create a personal access token for GitHub 
GITHUB_TOKEN=$GITHUB_TOKEN

# Setup gitops
./hack/flux.sh
```
