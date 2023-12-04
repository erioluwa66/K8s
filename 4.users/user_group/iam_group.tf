resource "aws_iam_group" "admin_group" {
  name = "admin_group"
}
resource "aws_iam_group" "developer_group" {
  name = "developer_group"

}
resource "aws_iam_user" "admin_users" {
    name  = var.admin_users

}
resource "aws_iam_user" "developer_users" {
  count = length(var.developer_users)
  name  = var.developer_users
}

resource "aws_iam_user_group_membership" "admin_group_membership" {
  user   =  aws_iam_user.admin_users.name
  groups = aws_iam_group.admin_group.name
}

resource "aws_iam_user_group_membership" "developer_group" {
  user   = tolist( aws_iam_user.developer_users.name )
  groups = aws_iam_group.developer_group.name
}