variable "vpc_name" {
    type = string
    description = "VPC name"
}

variable "zone" {
    type = string
    description = "subnet zone"
}

variable "cidr_block" {
    type = list(string)
    description = "subnet cidr"
}
