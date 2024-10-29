provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source                   = "../"
  bucket_name              = "my-secure-bucket"
  enable_versioning        = true
  encryption_algorithm     = "AES256"
  cross_account_iam_role_arns = ["arn:aws:iam::123456789012:role/ReadOnlyRole"]
  tags = {
    Environment = "dev"
    Owner       = "Manibharati"
  }
}
