variable "yc_token" {
  description = "OAuth token for YC"
  type = string
  sensitive = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type = string
}

variable "yc_folder_id" {
  description = "YC folder id"
  type = string
}

variable "yc_zone" {
  description = "Default availability zone"
  type = string
  default = "ru-central1-d"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type = string
  default = "netology-cloud-homework"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type = string
  default = "192.168.10.0/24"
}

variable "public_subnet_name" {
  description = "Name of public subnet"
  type = string
  default = "public"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type = string
  default = "192.168.20.0/24"
}

variable "private_subnet_name" {
  description = "Name of private subnet"
  type = string
  default = "private"
}

variable "nat_instance_image_id" {
  description = "Image ID for NAT instance"
  type = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat_instance_name" {
  description = "Name of NAT instance"
  type = string
  default = "nat-instance"
}

variable "nat_instance_address" {
  description = "Address of nat-instance"
  type = string
  default = "192.168.10.254"
}

variable "instance_nat_enable" {
  description = "Provide a public address for instance or not"
  type = bool
  default = true
}

variable "platform_id" {
  description = "Type of platform for instances"
  type = string
  default = "standard-v2"
}

variable "instances_resources" {
  description = "Resource size for instances"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number 
  }))
  default = {
    "nat-instance" = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
    "private-instance"  = {
      cores         = 2
      memory        = 4
      core_fraction = 50
    }
    "public-instance" = {
      cores         = 2
      memory        = 4
      core_fraction = 50
    }
  }
}

variable "instance_preemtible" {
  description = "Is the instance preemtible or not"
  type = bool
  default = true
}

variable "public_vm_name" {
  description = "Name of public vm"
  type = string
  default = "public-vm"
}

variable "private_instance_name" {
  description = "Name of private vm"
  type = string
  default = "private-vm"
}

variable "private_route_table_name" {
  description = "Name of private subnet route table"
  type = string
  default = "private-route-table"
}

variable "private_route_table_default_route_destination" {
  description = "Destination prefix for the default route"
  type = string
  default = "0.0.0.0/0"
}

variable "image_family" {
  description = "Image_family"
  type = string
  default = "ubuntu-2204-lts"
}
