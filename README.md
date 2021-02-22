Ccookiecutter for Infrastructure as Code with terraform 
========================================================

This is a cookiecutter based template for adding terraform to your project. This templates works with AWS. 
It should help your team w/ setting up the Infrastructure as Code part easily in a consistent way.

Benefits of using this template for your terraform IaC:
- makefile (justfile) driven control with standard targets like: `build`, `test`, `lint` etc. mathing the 
  corresponding terraform commands.
- dockerized setup to be independent of execution environment and installed terraform version
- this template is testable ;)

## Usage

This describes the installation of this template to your project.

What you need before: 
- [just](https://github.com/casey/just)
- [cookiecutter](https://cookiecutter.readthedocs.io/en/latest/index.html#)


## Develop

See usage for prerequisites.
Additionally you need:
- python

### Test

Tests are in `tests/` and are executed with `just test` from the root of the project. Tests will build in `build/tests/`.

## Contribute

Feel free to add issues for bugs and errors or even pull requests. Please keep in mind, this template should 
target AWS/terraform first, before extending it ;)
