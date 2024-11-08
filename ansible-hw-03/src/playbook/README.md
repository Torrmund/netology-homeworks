# Playbook для развертывания Clickhouse, Vector, Lighthouse и Nginx и проверки работоспособности этого стека.

Playbook направлен на создание тестовой среды для стека Clickhouse + Lighthouse + Vector + Nginx и изучения принципов работы этого стека.

В качестве кейса рассматривается парсинг access логов Nginx и отправки их через Vector в Clickhouse и последующим просмотров логов через Lighthouse.

Соответственно, на машине с Vector должен быть установлен Nginx.

Данный playbook поддерживает следующее:

* Может быть использован для развертывания Clickhouse, Vector, Lighthouse и Nginx на baremetal и VMs
* Поддерживает только последние версии дистрибутивов Debian и Ubuntu
* Позволяет указывать версию Clickhouse и Vector для установки
* Позволяет управлять репозиторием, с котрого устанавливается Clickhouse
* Позволяет управлять конфигурацией Vector
* Позволяет управлять списком хостов, с которых будет доступен Clickhouse через сеть
* Настроить синхронизацию Vector и Clickhouse
* Задавать название БД и таблицы, создаваемые в Clickhouse
* Позволяет управлять параметрами создания таблицы в Clickhouse

## Зависимости

* Ansible 2.9+

## Конфигурирование

### Доступные группы хостов:

* Clickhouse - для установки и конфигурирования Clickhouse
* Vector - для установки и конфигурирования Vector
* Nginx - для установки и конфигурирования Nginx
* Lighthouse - для установки lighthouse

### Доступные групповые переменные

* Файл `/group_vars/all/vars.ym` содержит переменные для всех групп:

  * `clickhouse_server_ip:` IP адрес машины с Clickhouse на борту для настройки подключения
  * `clickhouse_database_name:` Имя базы данных для создания и подключения к ней Vector
  * `clickhouse_table_name:` Имя таблицы для создания и подключения к ней Vector
* Файл `/group_vars/clickhouse/vars.yml` содержит переменные для для группы хостов, на которой разворачивается Clickhouse:

  * `clickhouse_version:`  Версия Clickhouse для установки
  * `clickhouse_packages:` Названия пакетов для установки Clickhouse
  * `clickhouse_gpg_key_url:` URL для получения ключа репозитория Clickhouse
  * `clickhouse_repo_url:` URL репозитория Clickhouse из которго будет выполняться установка
  * `clickhouse_table_field_options:` Опции создания таблицы в clickhouse
  * `clickhouse_listen_hosts:` Перечень хостов, доступ с которых есть к Clickhouse
* Файл `/group_vars/vector/vars.yml` содержит переменные для группы хостов, на которой разворачивается Vector. В частности переменную `vector_version:` которая задает версию Vector для установки.

### Соотношение play и групп хостов

| Play                             | Группа хостов |
| -------------------------------- | ------------------------- |
| Install Clickhouse               | clickhouse                |
| Install Vector                   | vector                    |
| Install nginx                    | nginx, lighthouse, vector |
| Install and configure Lighthouse | lighthouse                |

В файле ` /inventory/prod.yml` содержится инвентарь, в котором описываются хосты и параметры подключения к ним.

### Шаблоны конфигураций

В директории ./templates/ содержатся шаблоны конфигураций, позволяющие конфигурировать приложения.

| Файл                        | Описание                                                                                                               |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| clickhouse_listen_hosts.xml.j2  | Используется для создания дополнительного файла конфигурации Clickhouse |
| lighthouse_nginx_config.conf.j2 | Конфигурация Lighthouse для nginx                                                                               |
| vector_config.yaml.j2           | Конфигурация Vector                                                                                                |
| vector.service.j2               | Описание юнита systemd для Vector                                                                              |

## Особенности

Для использования данного playbook-а на managed-ноде у вас должна быть учетная запись с правами sudo.

## Установка

```
# Deploy with ansible playbook - run the playbook as root or user with sudo permissions
ansible-playbook -i inventory/inventory.yml playbook.yml -vv
```
