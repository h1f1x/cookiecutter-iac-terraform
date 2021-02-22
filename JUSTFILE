#!/usr/bin/env just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

TARGET_BASE_DIR := "build"

_default:
  @just --list

# Please read the README
init:
	@echo 'Please check the README for other required software!'

# Run tests
test: clean
	@just tests/all

# runs cookiecutter from you local version
run:
	@(cookiecutter --config-file default-config.yaml --output-dir {{TARGET_BASE_DIR}} .) || echo '[+] Hint: if 'directory already exists': re-run with: make clean build'
	@echo '[+] You will find the new project in: {{TARGET_BASE_DIR}}'

# re-run (replay) previous make run
build:
	@echo "[+] This will replay your last 'make run' ..."
	@cookiecutter --overwrite-if-exists --replay --config-file default-config.yaml --output-dir {{TARGET_BASE_DIR}} .

# cleans tests and build files
clean:
	@rm -rf {{TARGET_BASE_DIR}}

# cleans tests, build and cookiecutter replay files
clean-all:	clean
	@rm -f .cookiecutter_replay/*
