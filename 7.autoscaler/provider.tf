#terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#provider block
provider "aws" {
  region = "us-east-2"

}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../5.oidc_test/terraform.tfstate"
  }
}
