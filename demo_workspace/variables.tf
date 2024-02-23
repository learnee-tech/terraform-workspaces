variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/18"
  
}

variable "subnet_Name" {
  type = string
  default = "demo-subnet"
}

variable "ig_Name" {
  type = string
  default = "demo-ig"
}

variable "route_table_Name" {
  type = string
  default = "demo-route-table"
}

