output "vm_list" {
  value = concat( 
    [for i in range(length(yandex_compute_instance.web)) : {
      name = yandex_compute_instance.web[i].name
      id = yandex_compute_instance.web[i].id
      fqdn = yandex_compute_instance.web[i].fqdn
    }
    ],
    [for key, vm in yandex_compute_instance.db : {
      name = vm.name
      id = vm.id
      fqdn = vm.fqdn
    }
    ],
    [{
      name = yandex_compute_instance.storage.name
      id = yandex_compute_instance.storage.id
      fqdn = yandex_compute_instance.storage.fqdn
    }]
  )
}
