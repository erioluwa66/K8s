#1. Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "data.external.vpc_name.result.name"
  }
}