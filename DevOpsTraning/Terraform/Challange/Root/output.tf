output "dynamodb_table_name" {
  value = module.dynamodb.dynamodb_table_name
}

output "cross_account_iam_role_arns" {
  value = aws_iam_role.cross_account_role.arn
}

output "table_arn" {
  value = module.dynamodb.table_arn
}