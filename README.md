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

##