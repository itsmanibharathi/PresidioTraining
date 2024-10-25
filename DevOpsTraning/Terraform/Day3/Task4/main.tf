terraform {
  backend "s3" {
    bucket         = "mani-tf-backend"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mani-tf-backend-lock"
    encrypt        = true
  }
}

provider "aws" {
    region = "us-east-1"
    assume_role {
        role_arn = "arn:aws:iam::853973692277:role/mani_tf-cli"
        session_name = "mani"
    }
}

resource "aws_s3_bucket" "mani_tf-backend_test" {
    bucket = "mani-tf-backend-test"
    tags = {
        Name = "mani-tf-backend-test1"
    }
}