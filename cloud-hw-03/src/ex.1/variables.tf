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
    "lamp-instances"  = {
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

variable "image_family" {
  description = "Image_family"
  type = string
  default = "ubuntu-2204-lts"
}

variable "object_storage_backet_name" {
  description = "S3 backet name"
  type = string
  default = "netology-emav-cloud-hw"
}

variable "object_storage_backet_acl" {
  description = "ACL of bucket"
  type = string
  default = "public-read"
}

variable "object_storage_file_name" {
  description = "Filename of picture"
  type = string
  default = "cloud-hw-02-picture.jpg"
}

variable "object_storage_file_path" {
  description = "Filepath of picture"
  type = string
  default = "./example_image.jpg"
}

variable "object_storage_picture_acl" {
  description = "ACL of uploading picture"
  type = string
  default = "public-read"
}

variable "lamp_instance_group_name" {
  description = "Name of LAMP instance group"
  type = string
  default = "lamp"
}

variable "lamp_instance_image_id" {
  description = "Image ID of LAMP instances"
  type = string
  default = "fd827b91d99psvq5fjit"
}

variable "fixed_scale_count" {
  description = "Count of instances in instance group"
  type = number
  default = 3
}

variable "instance_group_max_unavailable" {
  type = number
  default = 1
}

variable "instance_group_max_expansion" {
  type = number
  default = 0
}

variable "instance_group_health_check_port" {
  type = number
  default = 80
}

variable "instance_group_health_check_path" {
  type = string
  default = "/"
}

variable "instance_group_sa_name" {
  description = "Name of service account for instance group"
  type = string
  default = "lamp-sa"
}

variable "instance_group_sa_description" {
  type = string
  default = "Service account for LAMP instance group"
}

variable "instance_group_sa_role" {
  type = string
  default = "editor"
}

variable "network_load_balancer_name" {
  type = string
  default = "lamp-nlb"
}

variable "nlb_healthcheck_name" {
  type = string
  default = "http-healthcheck"
}

variable "nlb_listener_name" {
  type = string
  default = "http"
}

variable "target_group_description" {
  type = string
  default = "Target group for nlb"
}

variable "target_group_name" {
  type = string
  default = "target-group"
}

variable "alb_target_group_name" {
  type = string
  default = "lamp-alb-target-group"
}

variable "alb_backend_group_name" {
  type = string
  default = "lamp-alb-backend-group"
}

variable "alb_http_backend_name" {
  type = string
  default = "lamp-backend"
}

variable "http_port" {
  type = number
  default = 80
}

variable "alb_panic_threshold" {
  type = number
  default = 90
}

variable "alb_healthcheck_timeout" {
  type = string
  default = "5s"
}

variable "alb_healthcheck_interval" {
  type = string
  default = "2s"
}

variable "alb_healthcheck_healthy_threshold" {
  type = number
  default = 2
}

variable "alb_healthcheck_unhealthy_threshold" {
  type = number
  default = 2
}

variable "alb_healthcheck_http_path" {
  type = string
  default = "/"
}

variable "alb_http_router_name" {
  type = string
  default = "lamp-alb-http-router"
}

variable "alb_vitrual_host_name" {
  type = string
  default = "lamp-alb-vitrual-host"
}

variable "root_route_name" {
  type = string
  default = "root-toute"
}

variable "alb_name" {
  type = string
  default = "lamp-alb"
}

variable "alb_listener_name" {
  type = string
  default = "http-listener"
}

variable "kms_simmetric_key_name" {
  type = string
  default = "storage-encryption-key"
}

variable "kms_simmetric_key_description" {
  type = string
  default = "Key for encrypting Object Storage bucket content"
}

variable "kms_simmetric_key_algorithm" {
  type = string
  default = "AES_256"
}

variable "kms_simmetric_key_rotation_period" {
  type = string
  default = "168h"
}
