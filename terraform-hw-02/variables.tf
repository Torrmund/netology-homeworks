###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_image_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "VM image family"
}

variable "vm_web_platform_name" {
  type = string
  default = "platform-web"
  description = "Resource name"
}

variable "vm_web_platform_id" {
  type = string
  default = "standard-v2"
  description = "Type of platform"
}

# variable "vm_web_cores_count" {
#   type = number
#   default = 2
#   description = "Count of cores for VM"
# }

# variable "vm_web_memory" {
#   type = number
#   default = 1
#   description = "Count of memory for VM"
# }

# variable "vm_web_core_fraction" {
#   type = number
#   default = 5
#   description = "CPU usage limit for VM"
# }

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))

  default = {
    "web" = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    },
    "db" = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "vm_web_preemtible" {
  type = bool
  default = true
  description = "Is the VM preemtible or not"
}

variable "vm_web_nat_enable" {
  type = bool
  default = true
  description = "Provide a public address for VM or not"
}

# variable "vm_web_serial_port_enable" {
#   type = number
#   default = 1
#   description = "Enable serial port on VM"
# }

variable "vms_metadata" {
  type = map(object({
    serial-port-enable = number
    ssh-keys           = string
  }))
  default = {
    "metadata" = {
      serial-port-enable = 1
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPseIuf21PQ0jy6XI785lv3aZh6q4xB1aH02l3zEMDJC emav@bfg.ai"
    }
  }
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPseIuf21PQ0jy6XI785lv3aZh6q4xB1aH02l3zEMDJC emav@bfg.ai"
  description = "ssh-keygen -t ed25519"
}
