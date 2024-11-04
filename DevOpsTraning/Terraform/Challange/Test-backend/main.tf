terraform {
  backend "s3" {
    bucket         = "tf-challenge-mani"
    key            = "terraform/state.tfstate"
    region         = "us-west-2"
    dynamodb_table = "mani_tf_backend_lock1"
    encrypt        = true
    # assume_role {
      role_arn = "arn:aws:iam::600441865524:role/cross_account_role"
    # }
  }
}

provider "aws" {
    region = "us-east-1"

}

resource "aws_s3_bucket" "mani_tf-backend_test" {
    bucket = "mani-tf-backend-test1"
    tags = {
        Name = "mani-tf-backend-test1"
    }
}