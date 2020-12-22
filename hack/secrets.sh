#!/bin/bash

# source ./variables.sh

clientId=$(az keyvault secret show --name "$connection_name-clientId" --vault-name "$resource_name" --query "value" -o tsv)
clientSecret=$(az keyvault secret show --name "$connection_name-clientSecret" --vault-name "$resource_name" --query "value" -o tsv)
subscriptionId=$(az keyvault secret show --name "$connection_name-subscriptionId" --vault-name "$resource_name" --query "value" -o tsv)
tenantId=$(az keyvault secret show --name "$connection_name-tenantId" --vault-name "$resource_name" --query "value" -o tsv)

export ARM_CLIENT_ID=$clientId
export ARM_CLIENT_SECRET=$clientSecret
export ARM_SUBSCRIPTION_ID=$subscriptionId
export ARM_TENANT_ID=$tenantId

echo "Secrets fetched..."