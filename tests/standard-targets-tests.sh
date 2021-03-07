#!/usr/bin/env bash

set -e
set -u

DST_BASE_DIR=../build/tests
terraform_dir_name="terraform"

source common.source

function test_w_docker() {
  DST_DIR=${DST_BASE_DIR}/unit_docker/
  PROJECT_SLUG='unittest_w_docker'
  rm -rf ${DST_DIR}

  cookiecutter --output-dir=${DST_DIR}/ --no-input $(pwd)/../ \
      project_name='Terraform Template Unit Tests with docker' \
      project_slug=${PROJECT_SLUG} \
      terraform_dir_name=${terraform_dir_name} \
      use_docker='y'

  execute_std_targets
  hr;
  echo "[*] All tests passed for '${PROJECT_SLUG}' !"; hr
  echo "[!] You will find the build in: ${DST_DIR}"
}

function test_wo_docker() {
  DST_DIR=${DST_BASE_DIR}/unit_tfenv/
  PROJECT_SLUG='unittest_without_docker'

  rm -rf ${DST_DIR}

  cookiecutter --output-dir=${DST_DIR}/ --no-input $(pwd)/../ \
      project_name='Terraform Template Unit Tests without docker' \
      project_slug=${PROJECT_SLUG} \
      terraform_dir_name=${terraform_dir_name} \
      use_docker='n'

  execute_std_targets
  hr;
  echo "[*] All tests passed for '${PROJECT_SLUG}' !"; hr
  echo "[!] You will find the build in: ${DST_DIR}"
}

test_w_docker
test_wo_docker
