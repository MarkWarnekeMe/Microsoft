export GITHUB_USER=MarkWarneke
export GITHUB_ORG=MarkWarnekeMe

flux bootstrap github \
    --owner=$GITHUB_ORG \
    --repository=Microsoft \
    --branch=main \
    --path=clusters/load-more \
    --version=latest \
    --token-auth
