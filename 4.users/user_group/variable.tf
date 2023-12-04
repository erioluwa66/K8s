variable "admin_users" {
  type    = list(string)
}

variable "developer_users" {
  type    = list(string)
  default = []
}