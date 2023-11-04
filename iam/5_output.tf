
output "node_role" {
  value = aws_iam_role.demo.arn

}

output "demo_role" {
  value = aws_iam_role.nodes.name
}