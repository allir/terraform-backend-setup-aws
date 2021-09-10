# terraform-backend-setup-aws

Set up S3 bucket and DynamoDB table to use for Terraform State Store and Locking.

## Usage

There is one required variable, `bucket_name`, that needs to be set. It can be set using `terraform apply -var=account_name=myaccount` or using a `.tfvars` file.

There are a few optional variables, like `aws_region`, `encrypt` and `workspace_key_prefix`.
An example `.tfvars` file: 

```bash
aws_region = "us-east-1"
bucket_name = "my-terraform-bucket"
encrypt = true
workspace_key_prefix = "Terraform"
```

### Plan

To see what will be created you can run:

```bash
terraform plan -var=account_name=myaccount
```

or `terraform plan -var-file=./myvars.tfvars`

### Apply

To create the resources run:

```bash
terraform apply -var=account_name=myaccount
```

### Generate

Once the resources have been created you can generate the backend configuration to use with other Terraform projects.

```bash
make generate
```

Copy the output and save it or redirect to a file.

```bash
# Redirect output directly to a file
make generate > backend.tf

# MacOS copy the output to clipboard
make generate | bpcopy
```
