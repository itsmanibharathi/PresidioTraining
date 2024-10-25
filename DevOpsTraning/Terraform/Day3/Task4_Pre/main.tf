terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    assume_role {
        role_arn = "arn:aws:iam::853973692277:role/mani_tf-cli"
        session_name = "mani"
    }
}

locals {
    common_tags = {
        owner = "mani"
        created_by = "terraform"
    }
}

resource "aws_s3_bucket" "mani_tf-backend" {
    bucket = "mani-tf-backend"
    tags = merge(local.common_tags, {
        Name = "mani-tf-backend"
    })
}

resource "aws_s3_bucket_versioning" "mani_tf-backend_versioning" {
    bucket = aws_s3_bucket.mani_tf-backend.id
    versioning_configuration {
        status = "Enabled"
    }
}
// policy to allow s3 bucket to be used as terraform backend

resource "aws_s3_bucket_policy" "mani_tf-backend_policy" {
    bucket = aws_s3_bucket.mani_tf-backend.id
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                "Effect": "Allow",
                "Principal": "*",  # Allows access from any principal
                "Action": "s3:ListBucket",
                "Resource": aws_s3_bucket.mani_tf-backend.arn,
            },
            {
                "Effect": "Allow",
                "Principal": "*",  # Allows access from any principal
                "Action": ["s3:GetObject", "s3:PutObject"],
                "Resource": "${aws_s3_bucket.mani_tf-backend.arn}/*",
            }
        ]
    })
}


// add dynamodb table for state locking
resource "aws_dynamodb_table" "mani_tf_backend_lock" {
    name           = "mani-tf-backend-lock"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = local.common_tags
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.mani_tf-backend.arn
  description = "The ARN of the S3 bucket for Terraform state."
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.mani_tf_backend_lock.name
  description = "The Name of the DynamoDB table for Terraform state locking."
}