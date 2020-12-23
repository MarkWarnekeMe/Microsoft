# Microsoft ![Terraform](https://github.com/MarkWarnekeMe/Microsoft/workflows/Terraform/badge.svg?branch=main) ![Kubernetes](https://github.com/MarkWarnekeMe/Microsoft/workflows/Kubernetes/badge.svg?branch=main) ![Hack](https://github.com/MarkWarnekeMe/Microsoft/workflows/Hack/badge.svg?branch=main)

Terraform OPS deployment.

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
