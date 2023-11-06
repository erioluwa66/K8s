#Provider block
provider "aws" {
  region  = "us-east-2"
  #profile = "eks-master"
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