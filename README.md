# terraform-backend-setup-aws

Set up S3 bucket and DynamoDB table to use for Terraform State Store and Locking.

## Usage

There is one required variable, `bucket_name`, that needs to be set. It can be set using `terraform apply -var=bucket_name=my-terraform-bucket` or using a `.tfvars` file.

There are a few optional variables, like `aws_region`, `encrypt` and `workspace_key_prefix`.
An example `.tfvars` file:

```bash
aws_region = "us-east-1"
bucket_name = "my-terraform-bucket"
encrypt = true
workspace_key_prefix = "terraform"
```

### Plan

To see what will be created you can run:

```bash
terraform plan -var=bucket_name=my-terraform-bucket
```

or

```bash
terraform plan -var-file=./myvars.tfvars
```

### Apply

To create the resources run:

```bash
terraform apply -var=bucket_name=my-terraform-bucket
```

or

```bash
terraform apply -var-file=./myvars.tfvars
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

### Backup

Since this terraform is meantto be used for the initalization of a backend S3 bucket for (other) terraform we don't expect this state to have a remote backend itself. Therefore it would be a good idea to back up the state manually, we can even copy it to the bucket we just created. But any remote location should be fine.

Using `awscli` we can copy the state files to the bucket:

```bash
aws s3 cp terraform.state s3://my-terraform-bucket/backup/terraform-backend/
```

To fetch the state at a later time:

```bash
aws s3 cp s3://my-terraform-bucket/backup/terraform-backend/terraform.tfstate ./
```
