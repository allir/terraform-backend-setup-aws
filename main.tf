terraform {
  required_providers {
    aws = {
      version = ">= 4.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  tags = {
    Terraform = "This resource was created by Terraform"
    Purpose = "Terraform State Store"
  }
}

resource "aws_s3_bucket" "terraform" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = local.tags
}

resource "aws_s3_bucket_acl" "terraform" {
  bucket = aws_s3_bucket.terraform.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform" {
  bucket = aws_s3_bucket.terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform" {
  bucket = aws_s3_bucket.terraform.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket = aws_s3_bucket.terraform.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
  
}

resource "aws_dynamodb_table" "terraform" {
  name           = "${var.bucket_name}-terraform-lock"
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

  tags = local.tags
}
