

data "aws_iam_users" "users" {}

resource "aws_iam_group_membership" "dev_team" {
  name  = "group-membership"
  users = data.aws_iam_users.users.names
  group = "Developer"
}
/*
output "users" {
  value = data.aws_iam_users.users.*.arns

}
output "users-names" {
  value = data.aws_iam_users.users.*.names
  
}
*/
