output "network_id" {
    value = yandex_vpc_network.develop.id
}

output "subnet_id" {
    value = yandex_vpc_subnet.develop.id
}

output "subnet_cidr" {
    value = yandex_vpc_subnet.develop.v4_cidr_blocks
}

output "subnet_zones" {
    value = yandex_vpc_subnet.develop.zone
}

output "subnet_name" {
    value = yandex_vpc_subnet.develop.name
}