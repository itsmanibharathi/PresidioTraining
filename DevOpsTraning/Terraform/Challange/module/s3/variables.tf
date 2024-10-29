variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  validation {
    condition     = length(var.bucket_name) > 0 && length(var.bucket_name) <= 63
    error_message = "Bucket name must be between 1 and 63 characters."
  }
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

variable "encryption_algorithm" {
  description = "The encryption algorithm to use (e.g., AES256 or aws:kms)"
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "aws:kms"], var.encryption_algorithm)
    error_message = "encryption_algorithm must be either AES256 or aws:kms."
  }
}

variable "cross_account_iam_role_arns" {
  description = "List of IAM Role ARNs for cross-account access"
  type        = list(string)
  validation {
    condition     = length(var.cross_account_iam_role_arns) > 0
    error_message = "At least one cross-account IAM role ARN must be provided."
  }
}

variable "logging_bucket" {
  description = "The name of the bucket for S3 logs (optional)"
  type        = string
  default     = ""
}

variable "logging_prefix" {
  description = "The prefix for S3 log objects (optional)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "block_public_acls" {
  description = "Block public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public bucket policies for the bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public bucket policies for the bucket"
  type        = bool
  default     = true
}
