# Создание VPC
resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}

# Создание публичной подсети
resource "yandex_vpc_subnet" "public_subnet" {
  name = var.public_subnet_name
  v4_cidr_blocks = [ var.public_subnet_cidr ]
  zone = var.yc_zone
  network_id = yandex_vpc_network.network.id
}

# Создание приватной подсети
resource "yandex_vpc_subnet" "private_subnet" {
  name = var.private_subnet_name
  v4_cidr_blocks = [ var.private_subnet_cidr ]
  zone = var.yc_zone
  network_id = yandex_vpc_network.network.id
}

# Создание бакета Object Storage
resource "yandex_storage_bucket" "bucket" {
  bucket = var.object_storage_backet_name
  acl = var.object_storage_backet_acl
  folder_id = var.yc_folder_id
}

# Загрузка файла с картинкой в бакет
resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.bucket.bucket
  key = var.object_storage_file_name
  source = var.object_storage_file_path
  acl = var.object_storage_picture_acl
}

# Создание Instance Group с 3 ВМ и шаблоном LAMP
resource "yandex_compute_instance_group" "lamp_group" {
  name = var.lamp_instance_group_name
  folder_id = var.yc_folder_id
  service_account_id = yandex_iam_service_account.sa.id
  instance_template {
    platform_id = var.platform_id
    resources {
      cores = var.instances_resources["lamp-instances"].cores
      memory = var.instances_resources["lamp-instances"].memory
      core_fraction = var.instances_resources["lamp-instances"].core_fraction
    }
    scheduling_policy {
      preemptible = var.instance_preemtible
    }
    boot_disk {
      initialize_params {
        image_id = var.lamp_instance_image_id
      }
    }
    network_interface {
      subnet_ids = [yandex_vpc_subnet.public_subnet.id]
    }
    metadata = {
      user-data = data.template_file.cloudinit.rendered
    }
  }
  scale_policy {
    fixed_scale {
      size = var.fixed_scale_count
    }
  }
  allocation_policy {
    zones = [ var.yc_zone ]
  }
  deploy_policy {
    max_unavailable = var.instance_group_max_unavailable
    max_expansion = var.instance_group_max_expansion
  }
  health_check {
    http_options {
      port = var.instance_group_health_check_port
      path = var.instance_group_health_check_path
    }
  }
  load_balancer {
    target_group_description = var.target_group_description
    target_group_name = var.target_group_name
  }

  depends_on = [ yandex_resourcemanager_folder_iam_member.editor ]
}

# Создание Service Account для Instance Group
resource "yandex_iam_service_account" "sa" {
  name = var.instance_group_sa_name
  description = var.instance_group_sa_description
}

# Назначение роли для SA
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.yc_folder_id
  role = var.instance_group_sa_role
  member = "serviceAccount:${yandex_iam_service_account.sa.id}"

  depends_on = [ yandex_iam_service_account.sa ]
}

# Создание Network Load Balancer
resource "yandex_lb_network_load_balancer" "nlb" {
  name = var.network_load_balancer_name

  listener {
    name = var.nlb_listener_name
    port = var.instance_group_health_check_port
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp_group.load_balancer.0.target_group_id

    healthcheck {
      name = var.nlb_healthcheck_name
      http_options {
        port = var.instance_group_health_check_port
        path = var.instance_group_health_check_path
      }
    }
  }
}

# Создание ALB Target Group
resource "yandex_alb_target_group" "alb_target_group" {
  name = var.alb_target_group_name
  target {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    ip_address   = yandex_compute_instance_group.lamp_group.instances[0].network_interface[0].ip_address
  }
  target {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    ip_address   = yandex_compute_instance_group.lamp_group.instances[1].network_interface[0].ip_address
  }
  target {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    ip_address   = yandex_compute_instance_group.lamp_group.instances[2].network_interface[0].ip_address
  }
}

# Создание ALB Backend Group
resource "yandex_alb_backend_group" "alb_backend_group" {
  name = var.alb_backend_group_name

  http_backend {
    name = var.alb_http_backend_name
    port = var.http_port
    target_group_ids = [ yandex_alb_target_group.alb_target_group.id ]
    load_balancing_config {
      panic_threshold = var.alb_panic_threshold
    }
    healthcheck {
      timeout = var.alb_healthcheck_timeout
      interval = var.alb_healthcheck_interval
      healthy_threshold = var.alb_healthcheck_healthy_threshold
      unhealthy_threshold = var.alb_healthcheck_unhealthy_threshold
      http_healthcheck {
        path = var.alb_healthcheck_http_path
      }
    }
  }
}

# Создание ALB HTTP Router
resource "yandex_alb_http_router" "alb_http_router" {
  name = var.alb_http_router_name
}

# Создание ALB Virtual Host
resource "yandex_alb_virtual_host" "alb_virtual_host" {
  name = var.alb_vitrual_host_name
  http_router_id = yandex_alb_http_router.alb_http_router.id

  route {
    name = var.root_route_name
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.alb_backend_group.id
      }
    }
  }
}

# Создание ALB Load Balancer
resource "yandex_alb_load_balancer" "alb" {
  name = var.alb_name

  network_id = yandex_vpc_network.network.id

  allocation_policy {
    location {
      zone_id = var.yc_zone
      subnet_id = yandex_vpc_subnet.public_subnet.id
    }
  }

  listener {
    name = var.alb_listener_name
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [ var.http_port ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb_http_router.id
      }
    }
  }
}

# Data source для получения image_id Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

# Data source для user_data (cloud-init)
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    bucket_name = yandex_storage_bucket.bucket.bucket
    image_key = yandex_storage_object.image.key
  }
}

# Data source для nlb
data "yandex_lb_network_load_balancer" "nlb_data" {
  network_load_balancer_id = yandex_lb_network_load_balancer.nlb.id
}
