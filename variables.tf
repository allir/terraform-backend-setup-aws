variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# Name for the S3 Bucket and DynamoDB table to store terraform state data
variable "bucket_name" {
  type = string
}

variable "workspace_key_prefix" {
  type = string
  default = "terraform"
}

variable "encrypt" {
  type = bool
  default = true
}
