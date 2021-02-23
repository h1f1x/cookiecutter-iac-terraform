Ccookiecutter for Infrastructure as Code with terraform 
========================================================

This is a cookiecutter based template for adding terraform to your project. This templates works with AWS. 
It should help your team w/ setting up the Infrastructure as Code part easily in a consistent way.

Benefits of using this template for your terraform IaC:
- makefile (justfile) driven control with standard targets like: `build`, `test`, `lint` etc. mathing the 
  corresponding terraform commands.
- dockerized setup to be independent of execution environment and installed terraform version
- this template is testable ;)

Example usage within my project where I wanted to add terraform to:

```
my_poject ➜ cookiecutter git@github.com:h1f1x/cookiecutter-iac-terraform.git                                                
terraform_dir_name [terraform]: 
project_name [Terraform Demo Project]: 
project_slug [terraform_demo_project]: 

my_poject ➜ tree terraform 
terraform
├── JUSTFILE
├── Makefile
├── README.md
├── backend.tf
├── main.tf
└── provider.tf

0 directories, 6 files
```

Now go to `terraform/` and check what you can do.
Don't forget to fetch aws credentials first, as you will need AWS access from now on.

```
my_poject ➜ cd terraform
my_poject/terraform ➜ just
Available recipes:
    apply             # executes terraform apply w/ auto-approve
    deploy            # alias for `apply`
    clean
    destroy           # executes terraform destroy w/ force
    undeploy          # alias for `destroy`
    fmt               # updates tf configurations in the current directory for easy readability and consistency
    autolint          # alias for `fmt`
    info              # prints important variables
    init              # terraform init w/ remote state
    local             # # terraform init w/ local state
    plan              # executes terraform plan
    build             # alias for `plan`
    show              # executes terraform show
    state *subcommand # executes terraform state w/ given subcommand
    test              # not implemented yet
    validate          # check and report errors within tf modules, attribute names, and value types
    lint              # alias for `validate`
```

You can now initialize the terraform like:
```
my_poject/terraform ➜ just init
[*] Initializing terraform with remote state: 's3://terraform-states-1234567890-eu-central-1/terraform_demo_project.json' ...

Initializing the backend...
[...]
```
And deploy:
```
my_poject/terraform ➜ just deploy
aws_iam_role.test-role: Creating...
aws_iam_role.test-role: Creation complete after 2s [id=terraform_demo_project-role]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

## Usage

This describes the installation of this template to your project in detail.

What you need before: 
- [just](https://github.com/casey/just)
- [cookiecutter](https://cookiecutter.readthedocs.io/en/latest/index.html#)

As most things are shown above, here only some additional things you might want to know. 
See also the README.md of the cookicutter output. Everything which relates to the terraform you can find there.

### Variables

As you call cookiecutter you will be asked for some input. Here they are:

### terraform_dir_name 
Which directory you want to put in your terraform files in. Name it according to your conventions for iaC. 
If you don't know leave it to the default.

### project_name 
Could be the name of you current project you want to add this terraform to.
It's only used to fill some project related texts from the template. 
So it will be used for tagging of your resources. 

### project_slug
This is a sanitized version of your project_name. Used for thing which cannot have spaces in text.


## Develop

See usage for prerequisites.
Additionally you need:
- python

### Test

Tests are in `tests/` and are executed with `just test` from the root of the project. Tests will build in `build/tests/`.

## Contribute

Feel free to add issues for bugs and errors or even pull requests. Please keep in mind, this template should 
target AWS/terraform first, before extending it ;)
