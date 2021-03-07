resource "aws_iam_role" "example-role" {
  name = "{{cookiecutter.project_slug}}-role"

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
  tags = var.resource_tags
}

resource "aws_dynamodb_table" "example-dynamodb-table" {
  name = "{{cookiecutter.project_slug}}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key         = "ExampleTableHashKey"
  attribute {
    name = "ExampleTableHashKey"
    type = "S"
  }
  tags = var.resource_tags
}
