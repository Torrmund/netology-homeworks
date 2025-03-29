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
  route_table_id = yandex_vpc_route_table.private_route_table.id
}

# Создание NAT-инстанса в публичной подсети
resource "yandex_compute_instance" "nat_instance" {
  name = var.nat_instance_name
  platform_id = var.platform_id
  zone = var.yc_zone

  resources {
    cores = var.instances_resources["nat-instance"].cores
    memory = var.instances_resources["nat-instance"].memory
    core_fraction = var.instances_resources["nat-instance"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_instance_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat = var.instance_nat_enable
    ip_address = var.nat_instance_address
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
  }
}

# Создание ВМ в публичной подсети
resource "yandex_compute_instance" "public_vm" {
  name = var.public_vm_name
  platform_id = var.platform_id
  zone = var.yc_zone

  resources {
    cores = var.instances_resources["public-instance"].cores
    memory = var.instances_resources["public-instance"].memory
    core_fraction = var.instances_resources["public-instance"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat = var.instance_nat_enable
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
  }
}

# Создание ВМ в приватной подсети
resource "yandex_compute_instance" "private_vm" {
  name = var.private_instance_name
  platform_id = var.platform_id
  zone = var.yc_zone

  resources {
    cores = var.instances_resources["private-instance"].cores
    memory = var.instances_resources["private-instance"].memory
    core_fraction = var.instances_resources["private-instance"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet.id
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
  }
}

# Создание route table для приватной подсети
resource "yandex_vpc_route_table" "private_route_table" {
  name = var.private_route_table_name
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = var.private_route_table_default_route_destination
    next_hop_address = yandex_compute_instance.nat_instance.network_interface[0].ip_address
  }
}

# Data source для получения image_id Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}
