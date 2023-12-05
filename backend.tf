terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.20.1"
    }
  }
  backend "s3" {
    bucket = "terraform-statefile-management-bucket01"
    key = "backend.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "tf-backend"
  }
}