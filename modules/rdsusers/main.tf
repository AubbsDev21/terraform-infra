resource "mysql_user" "create_user" {
    for_each = var.db_users
    user = each.value.username
    host = "http://aws-exapmle.com"
    password = each.value.password
}


resource "mysql_grant" "name" {
   for_each  = var.db_users
   
   user = each.value.username
   host = "http://aws-exapmle.com"
   database = var.database_name
   privileges = each.value.privileges

   depends_on = [ mysql_user.create_user ]
}