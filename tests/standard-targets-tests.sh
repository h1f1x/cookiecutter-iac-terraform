#!/usr/bin/env bash

set -e
set -u

DST_BASE_DIR=../build/tests/unit
terraform_dir_name='terraform'
PROJECT_SLUG='terraform_unit_tests'

source common.source

function create_project_from_cookiecutter() {
    cookiecutter --output-dir=${DST_BASE_DIR}/ --no-input $(pwd)/../ \
        project_name='Terraform Template Unit Tests' \
        project_slug=${PROJECT_SLUG} \
        terraform_dir_name=${terraform_dir_name}
}

rm -rf ${DST_BASE_DIR}
create_project_from_cookiecutter

pushd . > /dev/null
env_backup_and_set
echo $STAGE
cd ${DST_BASE_DIR}/${terraform_dir_name}
hr; echo "[${PROJECT_SLUG}] Testing just default taget ..."; hr
just .
hr; echo "[${PROJECT_SLUG}] Testing just target: init ..."; hr
just init
hr; echo "[${PROJECT_SLUG}] Testing just target: info ..."; hr
just info
hr; echo "[${PROJECT_SLUG}] Testing just target: build ..."; hr
just build
hr; echo "[${PROJECT_SLUG}] Testing just target: autolint ..."; hr
just autolint
hr; echo "[${PROJECT_SLUG}] Testing just target: lint ..."; hr
just lint
hr; echo "[${PROJECT_SLUG}] Testing just target: test ..."; hr
just test
hr; echo "[${PROJECT_SLUG}] Testing just target: clean ..."; hr
just clean
popd > /dev/null
env_restore

hr;
echo "[*] All tests passed for '${PROJECT_SLUG}' !"; hr
echo "[!] You will find the build in: ${DST_BASE_DIR}"

