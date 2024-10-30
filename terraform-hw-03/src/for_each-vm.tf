variable "each_vm" {
  type = list(object({
    name = string
    cores = number
    memory = number
    core_fraction = number

  }))
  default = [ 
    {
        name = "main"
        cores = 2
        memory = 2
        core_fraction = 20
    },
    {
        name = "replica"
        cores = 2
        memory = 1
        core_fraction = 5
    } 
  ]
}

resource "yandex_compute_instance" "db" {
  for_each = {for vm in var.each_vm : vm.name => vm}

  name = each.value.name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
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

  depends_on = [ yandex_vpc_network.develop, yandex_vpc_subnet.develop ]

}
