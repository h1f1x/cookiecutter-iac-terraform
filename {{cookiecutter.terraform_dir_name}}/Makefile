.ONESHELL:
.EXPORT_ALL_VARIABLES:
.DEFAULT_GOAL := help

DOCKER_IMAGE=hashicorp/terraform:light
DOCKER_ENV_ARGS := -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_ACCOUNT_ID -e AWS_REGION
DOCKER_MOUNTS=$$PWD/..:$$PWD/..
DOCKER_WORKDIR=$$PWD

DOCKER_ARGS=$(DOCKER_ENV_ARGS) -v $(DOCKER_MOUNTS) -w $(DOCKER_WORKDIR) -t $(DOCKER_IMAGE)

ifndef AWS_ACCOUNT_ID
	export AWS_ACCOUNT_ID=$(shell aws sts get-caller-identity --query 'Account' --output text)
endif

ifndef AWS_REGION
ifdef AWS_DEFAULT_REGION
	AWS_REGION=$(AWS_DEFAULT_REGION)
endif
endif

# --------------------------------------------------------------------------------------------
TF_STACK_NAME=boilerplate-test
TF_STATE_BUCKET=terraform-states-$(AWS_ACCOUNT_ID)-$(AWS_REGION)
# --------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------------
# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	$(info ${HELP_MESSAGE})
	@grep -Eh '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: info
info:
	$(info [*] Listing remote state bucket:)
	aws s3 ls $(TF_STATE_BUCKET)
	$(info [*] Listing TF_VARs env:)
	printenv | grep TF_VAR
	$(info [*] Listing current AWS env:)
	@echo AWS_REGION: $(AWS_REGION)
	@echo AWS_ACCOUNT_ID: $(AWS_ACCOUNT_ID)


.PHONY: init
init:  guard-AWS_REGION ## terraform init w/ remote state
	$(info [*] Initializing terraform ... )
	docker run -i $(DOCKER_ARGS) \
 		init -backend-config="bucket=$(TF_STATE_BUCKET)" -backend-config="key=$(TF_STACK_NAME).json"

.PHONY: debug
debug:  ## interactive shell into the docker env
	docker run -i --entrypoint '/bin/sh' $(DOCKER_ARGS)

.PHONY: plan
plan:
	$(info [*] Terraform plan ... )
	@docker run -i $(DOCKER_ARGS) plan

.PHONY: apply
apply:
	$(info [*] Terraform apply ... )
	@docker run -i $(DOCKER_ARGS) apply -auto-approve

.PHONY: destroy
destroy:
	$(info [*] Terraform destroy ... )
	@docker run -i $(DOCKER_ARGS) destroy -force

.PHONY: clean
clean:
	$(info [*] Cleanup any local terraform states ... )
	@rm -fr .terraform 2> /dev/null
	@rm -fr terraform.tfstate 2> /dev/null

# -------------------------------------------------------------------
# GENERAL HELPERS
# -------------------------------------------------------------------

guard-%:
	@if [ -z '${${*}}' ]; then echo '[!] Environment variable $* not set' && exit 1; fi

define HELP_MESSAGE
	Common usage:

	Make sure your have working credentials ans set the AWS_REGION.

	...::: Initialize Terraform w/ remote state :::...
	$ make all



endef