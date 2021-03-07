terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {}