variable "vm_db_image_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "VM image family"
}

variable "vm_db_platform_name" {
  type = string
  default = "platform-db"
  description = "Resource name"
}

variable "vm_db_platform_id" {
  type = string
  default = "standard-v2"
  description = "Type of platform"
}

# variable "vm_db_cores_count" {
#   type = number
#   default = 2
#   description = "Count of cores for VM"
# }

# variable "vm_db_memory" {
#   type = number
#   default = 2
#   description = "Count of memory for VM"
# }

# variable "vm_db_core_fraction" {
#   type = number
#   default = 20
#   description = "CPU usage limit for VM"
# }

variable "vm_db_preemtible" {
  type = bool
  default = true
  description = "Is the VM preemtible or not"
}

variable "vm_db_nat_enable" {
  type = bool
  default = true
  description = "Provide a public address for VM or not"
}

# variable "vm_db_serial_port_enable" {
#   type = number
#   default = 1
#   description = "Enable serial port on VM"
# }

variable "vm_db_zone" {
  type = string
  default = "ru-central1-b"
  description = "Custom zone for vm_db"
}

variable "vm_db_vpc_name" {
  type = string
  default = "develop_db"
  description = "Custom subnet name for db VM"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "Custom cidr for db VM subnet"
}

# variable "test" {
#   type = list(object({
#     name     = string
#     commands = list(string)
#   }))

#   default = [ {
#     name = "dev1"
#     commands = [
#         "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
#         "10.0.1.7"
#       ]
#     },
#     {
#     name = "dev2"
#     commands = [
#         "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
#         "10.0.2.29"
#       ]
#     },
#     {
#     name = "prod1"
#     commands = [
#         "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
#         "10.0.1.30"
#       ]
#   } ]
# }