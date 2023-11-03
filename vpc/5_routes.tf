# create private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  depends_on = [aws_subnet.private]

  tags = {
    Name = "private"
  }
}

#private routes
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  depends_on = [aws_route_table.private]

}
# create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public"
  }
}

#create public routes
resource "aws_route" "publc_internet_gateway" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [aws_route_table.public]

}
# Private route association
resource "aws_route_table_association" "private" {
  count = length(var.private_cidr)

  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id

  depends_on = [aws_route.private_nat_gateway, aws_subnet.private]
}

# Public route association
resource "aws_route_table_association" "public" {
  count = length(var.public_cidr)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id

  depends_on = [aws_route.publc_internet_gateway, aws_subnet.public]
}


