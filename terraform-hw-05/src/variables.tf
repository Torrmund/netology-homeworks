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
  description = "VPC network&subnet name"
}

###common vars

variable "ssh_public_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkFhQbkyKBQLx/LgtNuTSdDK0jRFbJQF0QxjTOroXFW emav@compute-vm-test-1"
  description = "ssh public key for cloudinit config"
}

variable "vm_username" {
  type = string
  default = "emav"
  description = "username for cloudinit config"
}

variable "marketing_vm_env_name" {
  type = string
  default = "marketing"
  description = "env name for marketing vms"
}

variable "analytics_vm_env_name" {
  type = string
  default = "analytics"
  description = "env name for analytics vms"
}

# variable "yandex_compute_instance_remote_source" {
#   type = string
#   default = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   description = "URL of the remote module yandex_compute_instance"
# }

variable "marketing_vm_name" {
  type = string
  default = "vm"
  description = "name for marketing vms"
}

variable "analytics_vm_name" {
  type = string
  default = "vm"
  description = "name for analytics vms"
}

variable "marketing_vms_image_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "image family for marketing vms"
}

variable "analytics_vms_image_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "image family for analytics vms"
}

variable "marketing_vms_count" {
  type = number
  default = 1
  description = "count of marketing vms"
}

variable "analytics_vms_count" {
  type = number
  default = 1
  description = "count of analytics vms"
}

variable "enable_public_ip" {
  type = bool
  default = true
  description = "enable public ip for vms or not"
}

variable "marketing_vms_labels" {
  type = map(string)
  default = {
    "owner" = "i.ivanov"
    "project" = "marketing"
  }
}

variable "analytics_vms_labels" {
  type = map(string)
  default = {
    "owner" = "p.petrov"
    "project" = "analytics"
  }
}

variable "vms_serial_port_enable" {
  type = number
  default = 1
  description = "enable serial port on vms"
}
