ARG AZURE_CLI_TAG="latest"

FROM mcr.microsoft.com/azure-cli:${AZURE_CLI_TAG}

ARG TERRAFORM_VERSION="0.13.2"
ARG TFLINT_VERSION="v0.19.1"
ARG TERRAFORM_DOCS_VERSION="v0.8.2"
ARG GO_VERSION="1.14.1"

RUN az aks install-cli

RUN apk --no-cache add curl jq python bash ca-certificates git openssl unzip wget vim

RUN cd /tmp && \
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN set -x && \
    wget https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip -O tflint.zip && \
    unzip tflint.zip -d /usr/local/bin/ && \
    rm tflint.zip

RUN cd /tmp && \
    wget -q https://github.com/segmentio/terraform-docs/releases/download/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-linux-amd64 -O /usr/local/bin/terraform-docs && \
    chmod +x /usr/local/bin/terraform-docs

# https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz
RUN cd /tmp && \
    wget -q https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf  go${GO_VERSION}.linux-amd64.tar.gz && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile  && \
    source ~/.profile && \
    chown root:root /usr/local/go/bin && \
    rm -rf go${GO_VERSION}.linux-amd64.tar.gz

VOLUME /source
WORKDIR /source

ENTRYPOINT ["bash"]