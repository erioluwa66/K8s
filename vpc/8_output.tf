output "private" {
  value = aws_subnet.private.*.id

}

output "Public" {
  value = aws_subnet.public.*.id

}

