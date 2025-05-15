variable "region" {
  type    = string
  default = "us-east-1"

}

variable "profile" {
  type    = string
  default = "default"

}

variable "vpc_name" {
  default = "dev-vpc"

}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_public_cidr" {
  type = map(object({
    cidr_block         = string
    availability_zones = string
  }))
  default = {
    "subnet-a" = {
      cidr_block         = "10.0.1.0/24"
      availability_zones = "us-east-1a"
    },
    "subnet-b" = {
      cidr_block         = "10.0.2.0/24"
      availability_zones = "us-east-1b"
    },
    "subnet-c" = {
      cidr_block         = "10.0.3.0/24"
      availability_zones = "us-east-1c"
    }
  }
}

variable "create_igw" {
  type    = bool
  default = true

}

variable "cidr_block_route" {
  type    = string
  default = "0.0.0.0/0"

}


###############################################
############## EC2 ############################
###############################################

variable "ec2_name" {
  type    = string
  default = "ec2_node"
}

variable "ec2_count" {
  type    = number
  default = 3
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-085386e29e44dacd7"
}

variable "environment" {
  type    = string
  default = "Dev"
}




