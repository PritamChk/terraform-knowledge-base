locals {
  users = csvdecode(file("./user-data.csv"))
  roles = toset(distinct([
    for u in local.users : u.role
  ]))
}

resource "aws_iam_group" "groups" {
  for_each = toset(local.roles)
  name     = each.value
  path     = "/groups/project_IAM/"
}

resource "aws_iam_user" "project_IAM_user" {

  for_each = { for user in local.users : user.email => user }
  name     = lower("${each.value.first_name}_${substr(each.value.last_name, 0, 4)}")
  path     = "/${lower(each.value.role)}/"

  tags = {
    project = "project_IAM"
    email   = each.key
    role    = each.value.role
  }
}

resource "aws_iam_user_login_profile" "project_IAM_user_login" {
  for_each                = aws_iam_user.project_IAM_user
  user                    = each.value.name
  password_reset_required = true
  password_length         = 8
}

resource "aws_iam_group_membership" "group_users_map" {

  for_each = toset(local.roles)
  name     = "group_users_map-${each.value}"
  group    = aws_iam_group.groups[each.key].name
  users = [
    for user in local.users :
    aws_iam_user.project_IAM_user.name
    if user.tag["role"] == each.value
  ]

}

#   pgp_key = "keybase:some_person_that_exists"
