output "dynamodb_table_name" {
  value       = aws_dynamodb_table.mani_tf_backend_lock.name
  description = "The Name of the DynamoDB table for Terraform state locking."
}

output "table_arn" {
  value       = aws_dynamodb_table.mani_tf_backend_lock.arn
  description = "The ARN of the DynamoDB table for Terraform state locking."
}