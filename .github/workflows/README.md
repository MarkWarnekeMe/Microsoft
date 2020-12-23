# workflows

## terraform.yaml

Following [Automate Terraform with GitHub Actions](https://learn.hashicorp.com/tutorials/terraform/github-actions).

![](https://learn.hashicorp.com/img/terraform/automation/tfc-gh-actions-workflow.png)

![](https://learn.hashicorp.com/img/terraform/automation/pr-master-gh-actions-workflow.png)

Adds a decent CI and CD solution that will plan on a PR and plan & deploy on merge to master.
Ensuring that master is always up to date and deployable.
Also it creates a sick PR comment with the plan:

![](https://learn.hashicorp.com/img/terraform/automation/gh-actions-pr-plan.gif)

## kubernetes.yaml

Noting yet.

Look into:

- [ ] `kubectl --dry-run`
- [ ] [kubeval](https://github.com/instrumenta/kubeval)
- [ ] [kube-score](https://github.com/zegl/kube-score)

## hack.yaml

Uses [shellcheck](https://www.shellcheck.net/) to lint bash scripts.
Rules can be found in [wiki](https://github.com/koalaman/shellcheck/wiki) via [`github.com/koalaman/shellcheck/wiki/**SC1118**`](https://github.com/koalaman/shellcheck/wiki/SC1118).