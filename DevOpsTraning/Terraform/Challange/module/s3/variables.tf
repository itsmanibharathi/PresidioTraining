variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = length(var.bucket_name) > 0
    error_message = "Bucket name must not be empty."
  }
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

  validation {
    condition     = contains(["AES256", "aws:kms"], var.encryption_algorithm)
    error_message = "Encryption algorithm must be either 'AES256' or 'aws:kms'."
  }
}

variable "logging_bucket" {
  description = "The bucket to store access logs in"
  type        = string
  default     = ""

  validation {
    condition     = length(var.logging_bucket) == 0 || can(regex("^[a-z0-9.-]{3,63}$", var.logging_bucket))
    error_message = "Logging bucket name must be a valid S3 bucket name (3-63 characters, lowercase letters, numbers, dots, or hyphens)."
  }
}

variable "logging_prefix" {
  description = "The prefix to use for access logs"
  type        = string
  default     = "logs/"

  validation {
    condition     = length(var.logging_prefix) > 0
    error_message = "Logging prefix must not be empty."
  }
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
  type        = string
  

  # validation {
  #   condition     = alltrue([for arn in var.cross_account_iam_role_arns : can(regex("^arn:aws:iam::[0-9]{12}:role/.+$", arn))])
  #   error_message = "Each IAM role ARN in cross_account_iam_role_arns must be a valid ARN in the format 'arn:aws:iam::account-id:role/role-name'."
  # }
}
