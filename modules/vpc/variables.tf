variable cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "deflaut vpc cidr block"
}

variable enable_dns_support {
    type = bool
    default = true
}

variable enable_dns_hostnames {
    type = bool
    default = true
    description = "This the variable for enabling dns hostname creation"
}

variable tags {
    type = map(string)
    default = {
        terraform   = "true"
    }
    description = "This a map variable that will take in multiple variables for taging"
    validation {
        condition = var.tags["terraform"] == "true"
        error_message = "The tag terraform = true is required"
    }
}

variable vpc_name {
    type = string
    default = "main"
    description = "This will be the name tag of a vpc taging"
}

variable vpc_environment {
    type = string
    default = "Dev"
    description = "This is the tags for the enviroment"
}

### IGW ######

variable create_igw {
  type        = bool
  default     = true
  description = "This variable detrime weather or not igw will be created"
}

########## Subnet ##############

variable "subnet_public_cidr" {
    type = map(object({
        cidr_block = string
        availability_zones = string
    }))
    default = {}
    description = "This is a list of cidr blocks based on the vpc cidr provides the amount of cidrs the"
  
}

variable "subnet_private_cidr" {
    type = map(object({
        cidr_block = string
        availability_zones = string
    }))
    default = {}
    description = "valThis is a list of cidr blocks based on the vpc cidr provides the amount of cidrs the"
}

variable "availability_zones" {
    type = list(string)
    default = [ "us-east-1a","us-east-1b","us-east-1c", ]
  
}

variable "cidr_block_route" {
    type = string
    default = "0.0.0.0/0"
    description = "This is the cidr block for the route table"
  
}

