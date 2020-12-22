#!/bin/bash

# source ./variables.sh

export ARM_CLIENT_ID=$(az keyvault secret show --name "$connection_name-clientId" --vault-name "$resource_name" --query "value" -o tsv)
export ARM_CLIENT_SECRET=$(az keyvault secret show --name "$connection_name-clientSecret" --vault-name "$resource_name" --query "value" -o tsv)
export ARM_SUBSCRIPTION_ID=$(az keyvault secret show --name "$connection_name-subscriptionId" --vault-name "$resource_name" --query "value" -o tsv)
export ARM_TENANT_ID=$(az keyvault secret show --name "$connection_name-tenantId" --vault-name "$resource_name" --query "value" -o tsv)

echo "Secrets fetched..."