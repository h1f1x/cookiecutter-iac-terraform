# IaC for {{cookiecutter.project_name}}

## Usage

What you need before: 
- [just](https://github.com/casey/just)
{%- if cookiecutter.use_docker == "y" %}
- [docker](https://docker.io)
{%- else %}
- [terraform](https://www.terraform.io/downloads.html)
{%- endif %}
- aws-cli
- s3 bucket for terraform remote state (see below for help)

Use the `just` command.

Please make sure you have an valid AWS session! You can check everything with `just info`.

## How to setup the terraform remote state s3 bucket

You can use cloudformation from your commandline to setup the needed s3 bucket with the following commands:

```yaml
cat << EOF > tf-state-bucket.yaml
AWSTemplateFormatVersion: 2010-09-09

Resources:
  terraformStateBucket:
    Type: 'AWS::S3::Bucket'
    Properties:
      BucketName: !Sub 'terraform-states-${AWS::AccountId}-${AWS::Region}'
      BucketEncryption:
        ServerSideEncryptionConfiguration:
          -
            BucketKeyEnabled: True
            ServerSideEncryptionByDefault:
              SSEAlgorithm: AES256
      PublicAccessBlockConfiguration:
        BlockPublicAcls: True
        BlockPublicPolicy: True
        IgnorePublicAcls: True
        RestrictPublicBuckets: True
EOF
aws cloudformation deploy --stack-name 'terraform-remote-stack' --template-file tf-state-bucket.yaml
```
It is already using some best practices in bucket naming, encryption at rest and protecting public access to it.
