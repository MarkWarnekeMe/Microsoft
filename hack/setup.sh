#!/bin/bash

# source ./variables.sh

#az login
az account set -s $subscription_id

# Create SPN
spn=$(az ad sp create-for-rbac --name $connection_name --role Contributor --scopes /subscriptions/$subscription_id --sdk-auth -o json)

# Save created SPN details
clientId=$(echo $spn | jq -r '.clientId') # Make sure jq is installed (`brew install jq`), query for property clientId `-r` raw (without quotes)
clientSecret=$(echo spn | jq -r '.clientSecret')
subscriptionId=$(echo $spn | jq -r '.subscriptionId')
tenantId=$(echo $spn | jq -r '.tenantId')

# Create Storage Account
group=$(az group create -g $resource_group_name -l $resource_location -o json)
storage_account=$(az storage account create -n $resource_name -g $resource_group_name -l $resource_location --sku Standard_LRS -o json)
storage_container=$(az storage container create -n $container_name --account-name $resource_name -o json)

# Create a KeyVault
keyvault=$(az keyvault create --location $resource_location --name $resource_name -g $resource_group_name -o json)

# Grant access to the automation SPN
az keyvault set-policy --name $resource_name --object-id $clientId --secret-permissions get list set

# Store created secrets
az keyvault secret set --name $connection_name-clientId --vault-name $resource_name --value $clientId
if [ $clientSecret ];
then
    az keyvault secret set --name $connection_name-azure-credentials --vault-name $resource_name --value $spn
    az keyvault secret set --name $connection_name-clientSecret --vault-name $resource_name --value $clientSecret
fi
az keyvault secret set --name $connection_name-subscriptionId --vault-name $resource_name --value $subscriptionId
az keyvault secret set --name $connection_name-tenantId --vault-name $resource_name --value $tenantId