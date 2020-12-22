.EXPORT_ALL_VARIABLES:
current_dir=$(shell pwd)

SHELL := /bin/bash

define find.functions
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
endef

help:
	@echo 'The following commands can be used.'
	@echo ''
	$(call find.functions)

chmod: ## chmdos necessary shell scripts
chmod:
	chmod +x ./hack/variables.sh
	chmod +x ./hack/secrets.sh

	chmod +x ./terraform/Microsoft/init.sh

.variables: chmod
	source ./hack/variables.sh

.secrets: .variables
	source ./hack/secrets.sh

init: ## sets up environment and installs requirements
init: .secrets
	cd ./terraform/Microsoft && ./init.sh

fmt:
fmt:
	cd 	./terraform/Microsoft && terraform fmt -check

plan:
plan:
	cd 	./terraform/Microsoft &&  ./plan.sh