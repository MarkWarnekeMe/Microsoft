terraform plan \
     -backend-config "resource_group_name=$TF_VAR_resource_group_name" \
     -backend-config "storage_account_name=$TF_VAR_storage_account_name" \
     -backend-config "container_name=$TF_VAR_container_name" \
     -backend-config "key=$TF_VAR_key"