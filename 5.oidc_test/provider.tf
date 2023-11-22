#Provider block
provider "aws" {
  region = "us-east-2"
}
#Terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}