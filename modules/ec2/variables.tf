variable "ami_id" {
 type        = string
 description = "The AMI ID to use for the instance"
 default     = "ami-085386e29e44dacd7"  
}

variable "ec2_count" {
    type = number
    default = 1
    description = "The number of ec2 instances needed"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
    description = "This is the variable that instance type"
  
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

variable "ec2_name" {
    type = string
    default = "default"
    description = "This is the name of the ec2 instnces"
}

variable "environment" {
    type = string
    default = "Dev"
    description = "This is the environment"
  
}

variable "subnet_id" {
    type = list(string)
    default = null
    
}

variable "vpc_security_group_ids" {
    type = list(string)
    default = null
  
}

variable "availability_zone" {
    type = string
    default = null

}

variable "user_data" {
    type = string
    default = null
}

variable "associate_public_ip_address" {
    type = bool
    default = true
}

######### EIP ##########

variable "instance" {
  type = string
  default = "value"
}