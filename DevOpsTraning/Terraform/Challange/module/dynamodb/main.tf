resource "aws_dynamodb_table" "mani_tf_backend_lock" {
    name           = var.table_name
    billing_mode   = var.billing_mode
    read_capacity  = var.read_capacity
    write_capacity = var.write_capacity
    # hash_key       = var.hash_key
    # attribute {
    #     name = var.hash_key
    #     type = "S"
    # }
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    server_side_encryption {
        enabled = var.enable_encryption
        kms_key_arn = var.aws_kms_key_arn
    }

    point_in_time_recovery {
        enabled = var.enable_recovery
    }
    tags = {
      Name = var.table_name
    }
}