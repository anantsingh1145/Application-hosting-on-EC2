resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-state-locking-test-vpc"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock"
    Environment = "test-vpc"
  }
}