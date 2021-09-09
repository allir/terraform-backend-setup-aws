provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terraform_s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Store"
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = ""
    enabled        = false
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Store"
  }
}
