terraform {
  required_version = "1.9.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
  
}

locals {
  common_tags = {
    owner = "mani"
  }
}

resource "aws_s3_bucket" "manit1" {
  bucket = "manit1"
  tags = merge(local.common_tags, {
    Name = "manit1"
  })
}

resource "aws_s3_bucket" "manit2" {
  provider = aws.west
  bucket = "manit2"
  tags = merge(local.common_tags, {
    Name = "manit2"
  })
}
