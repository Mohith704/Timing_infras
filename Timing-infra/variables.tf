variable "vpc_cidr" {
    type = string  
    default = "10.0.0.0/16"
}

variable "tags" { 
    type = map
    default = {
        Name = "timing"
        ENV = "Dev"
        Terraform = "true"
    }
}

variable "azs" {
    default = ["ap-south-1a","ap-south-1b"]
   
}

variable "public_subnet_cidr" {
    type = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
  
}

variable "public_subnet_names" {
    type = list
    default = ["timing-public-1a", "timing-public-1b"]
}

variable "igw_cidr" {
    type = string
    default = "0.0.0.0/0"
  
}

variable "private_subnet_cidr" {
    type = list
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_subnet_names" {
    type = list
    default = ["timing-private-1a", "timing-private-1b"]
}

variable "database_subnet_cidr" {
    type = list
    default = ["10.0.21.0/24", "10.0.22.0/24"]
  
}

variable "database_subnet_names" {
    type = list
    default = ["timing-database-1a", "timing-database-1b"]
  
}