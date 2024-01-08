resource "aws_iam_user" "user" {
  name = "${var.name}-terraform"

  tags = {
    managed-by = "manning-terraform"
    my-tag = "my-value"
  }
}

output "users" {
  value = aws_iam_user.user
}