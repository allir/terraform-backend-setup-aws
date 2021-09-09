variable "aws_region" {
  type    = string
  default = "us-west-2"
}

# Name for the S3 Bucket to store terraform state data
variable "bucket_name" {
  type = string
}

# Name for the DynamoDB table for locking terraform state data
variable "table_name" {
  type = string
}
