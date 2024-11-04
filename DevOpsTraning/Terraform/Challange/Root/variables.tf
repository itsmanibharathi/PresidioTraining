# Environment
variable "Environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
}

# Owner
variable "Owner" {
  description = "The owner of the resources"
  type        = string
}

# project
variable "project" {
  description = "The project name"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "cross_account_aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "cross_account_profile" {
  description = "The AWs profile to use for cross-account access"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "The server-side encryption algorithm to use (e.g., AES256, aws:kms)"
  type        = string
  default     = "AES256"
}

variable "logging_bucket" {
  description = "The bucket to store access logs in"
  type        = string
}

variable "logging_prefix" {
  description = "The prefix to use for access logs"
  type        = string
  default     = "logs/"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies"
  type        = bool
  default     = true
}

variable "cross_account_iam_role_arns" {
  description = "List of IAM role ARNs from other accounts that are allowed cross-account access"
  type        = list(string)
  default     = []
}


variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "The billing mode for the DynamoDB table"
  type        = string
  default     = "PROVISIONED"

  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "Billing mode must be either 'PROVISIONED' or 'PAY_PER_REQUEST'."
  }
}


variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
}

variable "enable_encryption" {
  description = "Whether to enable server-side encryption for the DynamoDB table"
  type        = bool
}

variable "enable_recovery" {
  description = "Whether to enable point-in-time recovery for the DynamoDB table"
  type        = bool
}



variable "read_capacity" {
  description = "The read capacity for the DynamoDB table"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "The write capacity for the DynamoDB table"
  type        = number
  default     = 5
}

variable "presidio_acount_iam_role_arns" {
  description = "The IAM role ARN for the Presidio account"
  type        = string
}