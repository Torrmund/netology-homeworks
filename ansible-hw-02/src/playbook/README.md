# Playbook для развертывания Clickhouse и Vector

Данный playbook поддерживает следующее:

* Может быть использован для развертывания Clickhouse и Vector на baremetal и VMs
* Поддерживает только последние версии дистрибутивов Debian и Ubuntu
* Позволяет указывать версию Clickhouse и Vector для установки
* Позволяет управлять репозиторием, с котрого устанавливается Clickhouse
* Позволяет управлять конфигурацией Vector

## Зависимости

* Ansible 2.9+

## Конфигурирование

В фалйах `/group_vars/all/vars.yml` и `/group_vars/clickhouse/vars.yml` указаны переменные с дефолтными значениями для установки Vector и Clickhouse соответственно.

В файле ` /inventory/prod.yml` содержится инвентарь, в котором описываются хосты и параметры подключения к ним.

## Особенности

Для использования данного playbook-а на managed-ноде у вас должна быть учетная запись с правами sudo.

## Установка

```
# Deploy with ansible playbook - run the playbook as root or user with sudo permissions
ansible-playbook -i inventory/prod.yml site.yml -vv
```

## Использование кастомной конфигурации Vector

Данный playbook также можно использовать как инструмент для редактирования конфигурации Vector.

Конфигурирование Vector производится путем внесения изменений в файл-шаблон `vector-config.yaml.j2` . После чего из этого шаблона генерируется файл конфигурации на managed-ноде.

## Список переменных

### Для установки ClickHouse

* `clickhouse_version:` string - Используется для указания версии ClickHouse для установки;
* `clickhouse_packages:` list - Список пакетов для установки clickhouse из официального репозитория;
* `clickhouse_gpg_key_url:` string - URL для получения ключа официального репозитория;
* `clickhouse_repo_url:` string - URL репозитория clickhouse.

### Для установки Vector

* `vector_version:` string - Используется для указания версии Vector для установки.
