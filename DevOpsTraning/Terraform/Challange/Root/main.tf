provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.Environment
      Owner       = var.Owner
      Terraform   = "true"
      Project     = var.project
    }
  }
}

provider "aws" {
  alias   = "cross_account"
  region  = var.cross_account_aws_region
  profile = var.cross_account_profile
}


resource "aws_iam_role" "cross_account_role" {
  provider = aws.cross_account
  name     = "cross_account_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.presidio_acount_iam_role_arns
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

// create the iam policy for cross-account access in cross_account
resource "aws_iam_policy" "cross_account_policy" {
  provider = aws.cross_account
  name        = "cross_account_policy"
  description = "Allow cross-account access to S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:PutObject", "s3:GetObject", "s3:ListBucket", "s3:DeleteObject"],
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      },
      {
        Effect   = "Allow",
        Action   = ["dynamodb:PutItem", "dynamodb:GetItem", "dynamodb:DeleteItem", "dynamodb:UpdateItem"],
        Resource = module.dynamodb.table_arn
      }
    ]
  })
}



// Attach the policy to the role in the cross_account
resource "aws_iam_role_policy_attachment" "attach_cross_account_policy" {
  provider   = aws.cross_account
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_policy.cross_account_policy.arn
}

module "secure_s3_bucket" {
  source                      = "git@gitlab.presidio.com:manibharathim/tf.git//s3"
  bucket_name                 = var.bucket_name
  enable_versioning           = var.enable_versioning
  encryption_algorithm        = var.encryption_algorithm
  logging_bucket              = var.logging_bucket
  logging_prefix              = var.logging_prefix
  block_public_acls           = var.block_public_acls
  block_public_policy         = var.block_public_policy
  ignore_public_acls          = var.ignore_public_acls
  restrict_public_buckets     = var.restrict_public_buckets
  cross_account_iam_role_arns = aws_iam_role.cross_account_role.arn
}

resource "aws_kms_key" "dynamodb_key" {
  description             = "KMS key for DynamoDB table encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

module "dynamodb" {
  source            = "git@gitlab.presidio.com:manibharathim/tf.git//dynamodb"
  table_name        = var.table_name
  hash_key          = var.hash_key
  billing_mode      = var.billing_mode
  enable_encryption = var.enable_encryption
  enable_recovery   = var.enable_recovery
  aws_kms_key_arn   = aws_kms_key.dynamodb_key.arn
  read_capacity     = var.read_capacity
  write_capacity    = var.write_capacity
}