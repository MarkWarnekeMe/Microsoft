# clusters

Contains configuration for all k8s clusters. Clusters are managed with GitOps

- [github: fluxcd/flux2](https://github.com/fluxcd/flux2)
- [docs](https://toolkit.fluxcd.io/)

Setup using [flux.sh](../hack/flux.sh)

```sh
 # Run installation checks
flux check

# update flux based on git changes
flux reconcile source git flux-system

# apply / resume updates
flux resume kustomization flux-system
```

## load-more

Development cluster.
