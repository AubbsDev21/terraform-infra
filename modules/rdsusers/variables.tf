variable "db_users" {
    type = map(object({
        username = string
        password = string 
        privileges = list(string)

    }))

    description = "This the map variable for the db users"
    default = {
      "db_user" = {
        username = "db_user"
        password = "db_user_secert"
        privileges = ["SELECT", "INSERT"]
        
      },
       "db_user2" = {
        username = "db_user2"
        password = "db_password2"
        privileges = ["SELECT", "INSERT"]
       }
    }
  
}

variable "database_name" {
    type = string
    description = "This is the name of the database"
    default = "my_database"
  
}

