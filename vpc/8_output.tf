output "private" {
    value = aws_subnet.private.*.id
  
}

output "Public" {
    value = aws_subnet.public.*.id
  
}

output "node_role" {
    value = aws_iam_role.demo.arn
  
}

output "demo_role" {
    value = aws_iam_role.nodes.name
  }