variable "table_name" {
  description = "The name of the DynamoDB table."
  type        = string
}



variable "hash_key" {
  description = "The attribute name used as the hash (partition) key."
  type        = string
}

variable "billing_mode" {
  description = "The billing mode for the table."
  type        = string
  default     = "PROVISIONED"
}

variable "enable_encryption" {
  description = "Whether to enable server-side encryption."
  type        = bool
  default     = true
}

variable "enable_recovery" {
  description = "Whether to enable point-in-time recovery."
  type        = bool
  default     = true
}

variable "aws_kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption."
  type        = string
  default     = ""
}

variable "read_capacity" {
  description = "The number of read units for this table."
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "The number of write units for this table."
  type        = number
  default     = 5
}