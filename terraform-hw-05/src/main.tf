module "vpc" {
  source = "./vpc/"
  vpc_name = var.vpc_name
  zone = var.default_zone
  cidr_block = var.default_cidr
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab"
  env_name       = var.marketing_vm_env_name
  network_id     = module.vpc.network_id
  subnet_zones   = [module.vpc.subnet_zones]
  subnet_ids     = [module.vpc.subnet_id]
  instance_name  = var.marketing_vm_name
  instance_count = var.marketing_vms_count
  image_family   = var.marketing_vms_image_family
  public_ip      = var.enable_public_ip

  labels = var.marketing_vms_labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.vms_serial_port_enable
  }
}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab"
  env_name       = var.analytics_vm_env_name
  network_id     = module.vpc.network_id
  subnet_zones   = [module.vpc.subnet_zones]
  subnet_ids     = [module.vpc.subnet_id]
  instance_name  = var.analytics_vm_name
  instance_count = var.analytics_vms_count
  image_family   = var.analytics_vms_image_family
  public_ip      = var.enable_public_ip

  labels = var.analytics_vms_labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.vms_serial_port_enable
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_public_key = var.ssh_public_key
    username = var.vm_username
  }
}
