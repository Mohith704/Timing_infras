variable "security_group_name" {
    type = string
}

variable "security_group_desc" {
    type = string
  
}

variable "security_group_tags"{
   type = map
   default = {}
}

variable "tags"{
   type = map
}

variable "vpc_id" {
    type = string
  
}