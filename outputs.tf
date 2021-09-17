output "backend" {
    value = {
        region = var.aws_region
        bucket = aws_s3_bucket.terraform.id
        dynamodb_table = aws_dynamodb_table.terraform.name
        key = "terraform/${aws_s3_bucket.terraform.id}.tfstate"
        encrypt = var.encrypt
    }
}