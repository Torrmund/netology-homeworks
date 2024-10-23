resource "yandex_compute_disk" "example_count" {
  count = 3
  name = "example-disk-${count.index + 1}"
  zone = var.default_zone
  size = var.count_disk_size
}

resource "yandex_compute_instance" "storage" {
  name = var.vm_storage_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemtible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat_enable
  }
    metadata = {
    serial-port-enable = var.vms_serial_port_enable
    ssh-keys           = "ubuntu:${local.public_ssh_key}"
  }

    depends_on = [ yandex_compute_disk.example_count, yandex_vpc_network.develop, yandex_vpc_subnet.develop ]

    dynamic "secondary_disk" {
      for_each = toset(yandex_compute_disk.example_count[*].id)
      content {
        disk_id = secondary_disk.value
      }
    }

}
