output "backend" {
    value = {
        region = var.aws_region
        bucket = aws_s3_bucket.terraform_s3_bucket.id
        dynamodb_table = aws_dynamodb_table.terraform_lock_table.name
        key = "${aws_s3_bucket.terraform_s3_bucket.id}.tfstate"
        workspace_key_prefix = var.workspace_key_prefix
        encrypt = var.encrypt
    }
}