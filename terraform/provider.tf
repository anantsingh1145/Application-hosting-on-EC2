terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  
  backend "s3" {
    bucket         = "terraform-state-bucket-test-vpc" 
    key            = "terraform/terraform.tfstate"   
    region         = "us-east-1"                                
    encrypt        = true                                       
    dynamodb_table = "terraform-state-locking-test-vpc"                 
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}