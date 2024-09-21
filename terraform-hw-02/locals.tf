locals {
  instance_name_web = "netology-${ var.vpc_name }-${ var.vm_web_platform_name }"
  instance_name_db  = "netology-${ var.vpc_name }-${ var.vm_db_platform_name }"
}