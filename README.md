<h1 align="center">🚀 Application hosting on EC2</h1> Application-hosting-on-EC2

---
# Creating the Infrastructure for the application
---

```markdown
# 🚀 Production Infrastructure Provisioning with Terraform

This repository contains Terraform configuration files to provision secure, scalable, and production-grade AWS infrastructure components such as VPC, Auto Scaling Group (ASG), S3 bucket, and DynamoDB.

> ⚠️ **This setup is intended for a Production environment.** Please follow best practices and apply proper IAM restrictions and security controls before running.

---

## 🧰 Prerequisites

Ensure the following are installed and configured on your machine:

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- AWS credentials (set via `aws configure` or environment variables)
- Git

---

## 📁 Project Structure

```bash
.
├── README.md
├── terraform/
│   ├── asg.tf
│   ├── dynamo-db.tf
│   ├── provider.tf
│   ├── s3.tf
│   ├── terraform.tfvars         # <-- Ignored (contains production secrets/inputs)
│   ├── terraform.tfstate        # <-- Ignored (state should be remote)
│   ├── terraform.tfstate.backup # <-- Ignored
│   ├── variable.tf
│   └── vpc.tf
└── .gitignore
```

````

---

## ⚙️ How to Deploy Production Infrastructure

### Step 1: Clone the Repository

```bash
git clone https://github.com/anantsingh1145/Application-hosting-on-EC2
cd Application-hosting-on-EC2/terraform
````

### Step 2: Configure Backend for Remote State

Edit `provider.tf` or a separate `backend.tf` file with your **Production S3 bucket and DynamoDB table**:

```hcl
terraform {
  backend "s3" {
    bucket         = "prod-terraform-state-bucket"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "prod-terraform-locks"
  }
}
```

### Step 3: Initialize Terraform

```bash
terraform init
```

### Step 4: Review the Execution Plan

```bash
terraform plan -var-file="terraform.tfvars"
```

### Step 5: Apply the Changes

```bash
terraform apply -var-file="terraform.tfvars"
```

---

## 🔐 Best Practices for Production

### ✅ Store State Securely in S3

Remote state enables collaboration and disaster recovery. Use an **S3 bucket** with:

* Versioning enabled
* Bucket encryption (SSE or SSE-KMS)
* IAM access restrictions
* Private ACL and proper bucket policy

### ✅ Enable Locking with DynamoDB

Prevent concurrent state writes by configuring a DynamoDB table for **state locking**:

```hcl
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "prod-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = "Production"
  }
}
```

### ✅ Follow IAM Best Practices

* Use a dedicated IAM role for CI/CD Terraform pipelines.
* Grant **least-privilege** permissions to only required services.
* Rotate credentials and use temporary tokens with MFA if possible.

---

## 📁 `.gitignore` – Protect Sensitive & Generated Files

```gitignore
# Terraform state and backups
*.tfstate
*.tfstate.backup

# Sensitive input files
*.tfvars

# Terraform plugin and cache directories
.terraform/

# Crash logs
crash.log
crash.*.log

# Override or debug files
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Plan outputs
*.tfplan
```

---

## ✅ Suggested Production Environment Standards

| Resource   | Recommendation                                                   |
| ---------- | ---------------------------------------------------------------- |
| S3         | Bucket with versioning, encryption, no public ACL                |
| DynamoDB   | Used for state locking                                           |
| IAM        | Use roles, enforce MFA, least privilege                          |
| Secrets    | Never store secrets in `.tfvars`, use AWS SSM or Secrets Manager |
| Versioning | Use tagged releases for deployments                              |

---

## 🏁 Contributing

This infrastructure is production-critical. Please open a PR with your suggested changes and clearly mention the environment impact.

---

