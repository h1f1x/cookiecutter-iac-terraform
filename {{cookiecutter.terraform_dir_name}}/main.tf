resource "aws_iam_role" "test-role" {
  name = "{{cookiecutter.project_slug}}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Deny",
      "Sid": "test"
    }
  ]
}
EOF
}

