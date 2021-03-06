locals {
  name_suffix = "${var.project_name}-${var.environment}"
  required_tags = {
    Project     = var.project_name,
    Environment = var.environment,
    Owner       = var.owner
  }
  tags = merge(var.resource_tags, local.required_tags)
}

# ---------------------------------------------------------------------------------------------------------------------

resource "aws_iam_role" "example-role" {
  name = "role-${local.name_suffix}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = local.tags
}

# ---------------------------------------------------------------------------------------------------------------------

resource "aws_dynamodb_table" "example-dynamodb-table" {
  name         = local.name_suffix
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ExampleTableHashKey"
  attribute {
    name = "ExampleTableHashKey"
    type = "S"
  }
  tags = local.tags
}

# ---------------------------------------------------------------------------------------------------------------------

resource "random_pet" "petname" {
  length    = 3
  separator = "-"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "example" {
  bucket = "${random_pet.petname.id}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}
