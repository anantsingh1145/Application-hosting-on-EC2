resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-state-bucket-${var.environment}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256" # Or "aws:kms"
      }
    }
  }

  tags = {
    Name        = "Terraform Remote State"
    Environment = "DevOps"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}