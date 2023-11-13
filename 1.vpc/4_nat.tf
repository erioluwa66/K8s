# Create EIP
resource "aws_eip" "nat" {

  tags = {
    Name = "nat"
  }
}

#Create NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}