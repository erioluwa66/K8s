#0. Using external data to generate VPC time stamp
data "external" "vpc_name" {
  program = ["python", "${path.module}\\name.py"]
}
#1. Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "data.external.vpc_name.result.name"
  }
}