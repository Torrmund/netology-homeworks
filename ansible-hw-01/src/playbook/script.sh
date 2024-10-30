#!/bin/bash

# Массив с именами контейнеров и образами
declare -A containers
containers=( ["alpine"]="pycontribs/alpine" ["debian"]="pycontribs/debian" ["fedora"]="pycontribs/fedora" )

# Создание и запуск контейнеров
for container in "${!containers[@]}"; do
    echo "Создание и запуск контейнера: $container"
    docker run -itd --name "$container" "${containers[$container]}"
done

# Запуск Ansible playbook
echo "Запуск Ansible playbook..."
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

# Удаление контейнеров
for container in "${!containers[@]}"; do
    echo "Удаление контейнера: $container"
    docker rm -f "$container"
done
echo "Все контейнеры удалены."