#!/bin/bash

export subscription_id=a287d458-0ab8-4a73-9ca6-6f44345f1ada
export connection_name=markwarnekeme-github
export resource_name=markwarnekeme
export resource_group_name=markwarnekeme
export resource_location=germanywestcentral
export container_name=terraform-state

export TF_VAR_resource_group_name="$resource_group_name"
export TF_VAR_storage_account_name="$resource_name"
export TF_VAR_container_name="$container_name"
export TF_VAR_key=terraform.tfstate