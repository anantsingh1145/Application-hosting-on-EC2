variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
}


variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "The AWS availability zones to deploy the resources"
  type        = list(string)
}

variable "private_subnets" {
  description = "The private subnets to deploy the resources"
  type        = list(string)
}

variable "public_subnets" {
  description = "The public subnets to deploy the resources"
  type        = list(string)
}


variable "environment" {
  description = "The environment to deploy the resources"
  type        = string
}