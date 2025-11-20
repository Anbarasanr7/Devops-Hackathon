variable "cidr_block" { type = string, default = "10.0.0.0/16" }
variable "azs" { type = list(string), default = ["ap-south-1a","ap-south-1b"] }
variable "env" { type = string }
variable "name" { type = string, default = "hackathon" }
