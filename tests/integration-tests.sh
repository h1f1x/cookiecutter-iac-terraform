#!/usr/bin/env bash

set -e
set -u

DST_BASE_DIR=../build/tests/integration
PROJECT_SLUG='cookiecutter_iac_terraform_test'
terraform_dir_name='terraform'

source common.source

function create_project_from_cookiecutter() {
    cookiecutter --output-dir=${DST_BASE_DIR}/ --no-input $(pwd)/../ \
        project_name='Cookiecutter IAC Terraform Integration Tests' \
        project_slug=${PROJECT_SLUG} \
        terraform_dir_name=${terraform_dir_name} \
        use_docker="n"
}

rm -rf ${DST_BASE_DIR}
create_project_from_cookiecutter

pushd . > /dev/null
env_backup_and_set
echo $STAGE

export TF_IN_AUTOMATION=1
export TF_LOG=TRACE
export TF_LOG_PATH=./terraform.log
export TF_VAR_project_name="${PROJECT_SLUG}"
export TF_VAR_owner="${USER}"
export TF_VAR_environment="${STAGE}"

cd ${DST_BASE_DIR}/${terraform_dir_name}
just info
hr; echo "[${PROJECT_SLUG}] Testing just target: init ..."; hr
just init
hr; echo "[${PROJECT_SLUG}] Testing just target: apply ..."; hr
just apply
hr; echo "[${PROJECT_SLUG}] Testing just target: show ..."; hr
just show
hr; echo "[${PROJECT_SLUG}] Testing just target: state list ..."; hr
just state list
hr; echo "[${PROJECT_SLUG}] Testing just target: destroy ..."; hr
just destroy
popd > /dev/null
env_restore


hr;
echo -e "\e[32m[*] All tests passed for '${PROJECT_SLUG}' !"; hr
echo "[!] You will find the build in: ${DST_BASE_DIR}/${terraform_dir_name}"