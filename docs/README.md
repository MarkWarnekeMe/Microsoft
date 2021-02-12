# Documentation

## Tools


### Kubernetes

| Name | Comment |
| --- | ---|
| [kubectx](https://github.com/ahmetb/kubectx) | Faster way to switch between clusters and namespaces in kubectl. |
| [k8slens](https://k8slens.dev/) | Lens is the only IDE you’ll ever need to take control of your Kubernetes clusters. |
| [akv2k8s](https://akv2k8s.io/) | zure Key Vault to Kubernetes (akv2k8s) makes Azure Key Vault secrets, certificates and keys available in Kubernetes and/or your application - in a simple and secure way. |
| [flux](https://toolkit.fluxcd.io) | The GitOps Toolkit is a set of composable APIs and specialized tools that can be used to build a Continuous Delivery platform on top of Kubernetes.  |


### Terraform

| Name | Comment | 
| --- | --- |
| [terratest](https://terratest.gruntwork.io/) | Terratest is a Go library that provides patterns and helper functions for testing infrastructure. |

### Shell

| Name | Comment | 
| --- | --- |
| [shellcheck](https://www.shellcheck.net/) | finds bugs in your shell scripts. |
| [detect-secrets](https://github.com/Yelp/detect-secrets) | detect-secrets is an aptly named module for (surprise, surprise) detecting secrets within a code base. |
| [markdownlint](https://github.com/markdownlint/markdownlint) | A tool to check markdown files and flag style issues. |

## Tips

Rename `kubectl` to `k` in order to run kubectl quicker e.g. `k get po -A` instead of `kuebctl get pods -A`

```sh
# add to ~/.bashrc or ~/.zshrc
alias k=kubectl
```
