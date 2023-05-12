variable "vpc_cidr" {
    type = string  #User should provide this value

}

variable "tags" { #common tags 
    type = map
}

variable "vpc_tags" {
    type = map
    default = {} #optional for user
}

variable "azs" {
    type = list
}    

variable "public_subnet_cidr" {
    type = list
}    

variable "public_subnet_tags" {
    type = map
    default = {}
  
}

variable "public_subnet_names" {
   type = list
}

variable "igw_cidr" {
    type = string
}

variable "public_route_tbl_tags" {
    type = map
    default = {}
}

variable "public_route_tbl_name" {
     type = string
}

variable "private_subnet_cidr" {
    type = list
}     

variable "private_subnet_tags" {
   type = map
    default = {}
}

variable "private_subnet_names" {
   type = list
}

variable "private_route_tbl_tags" {
    type = map
    default = {}
}

variable "private_route_tbl_name" {
     type = string
}


variable "database_subnet_cidr" {
    type = list
}    

variable "database_subnet_tags" {
    type = map
    default = {}
}

variable "database_subnet_names" {
   type = list
}

variable "database_route_tbl_tags" {
    type = map
    default = {}
}

variable "database_route_tbl_name" {
     type = string
}
