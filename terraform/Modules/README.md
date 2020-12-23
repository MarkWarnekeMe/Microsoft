# Modules

## Test

Run inside the provided Docker image [azure-terraform-cli](./Dockerfile)

- Change values in [test.vars](test.vars) to match the test environment
- Probably the values for dependent Resources e.g. KeyVault and Log Analytics keys have changed
  - [ ] (TODO: find way to query this dynamically)
- Add any environment variables through  a `.env`

```shell
# Build docker image
docker build --build-arg AZURE_CLI_TAG=${AZURE_CLI_TAG} --build-arg TERRAFORM_VERSION=${TERRAFORM_VERSION} -t ${DOCKER_TAG}:latest .

# Run docker
docker run -it -v ${PWD}:/source ${DOCKER_TAG}

# source go (profile is available within the docker)
source ~/.profile

# change to module
cd <tfmodule>

# change to test folder
cd test

# install test dependencies
go mod init 'github.com/MarkWarnekeMe/Microsoft/_git/terraform/Modules'

# Make sure to set an appropriate timeout
go test # -timeout 30m
```

### Test Process

- All modules are without a provider, so that provider can be configured centrally (parent terraform module)
- Creates a random name that is used for testing
- Create terraform options, e.g. references a static [`test.vars`](test.vars)
  - options are similar to the terraform command line arguments, see:
  - `plan -input=false -lock=false -var name=t7943 -var-file ./test/test.vars -lock=false`
- Moves `provider.tf` into the module (`../`)
- Runs `terraform plan` & `terraform apply`
- Moves `provider.tf` back

### Debugging

comment out `terraform.InitAndApply` to only run the plan for debugging.

```go
// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
terraform.InitAndApply(t, terraformOptions)
```
