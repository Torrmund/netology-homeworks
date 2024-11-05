# Домашнее задание к занятию 2 "Работа с Playbook"

## Основная часть

|                                                                                                           Описание задачи                                                                                                           | Описание выполняемых действий                                                                                                                                                                                                                                                     | Скриншоты                                                                          |
| :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- |
|                                                                                                   1. Подготовить инвентарь                                                                                                   | Подготовлен инвентарь                                                                                                                                                                                                                                                                    | ![1730763031436](image/README/1730763031436.png)                                              |
| 2. Дописать playbook.<br />Добавить Play, <br />который устанавливает <br />и настривает vector.<br />Конфигурация должна деплоиться <br />через шаблон j2. | Переработан playbook с учетом<br />рекомендаций по установке clickhouse<br />из репозитория для debian.<br />Добавлен play установки vector <br />из скачиваемого архива с бинарником.              | С кодом можно ознакомиться в файле<br />/src/playbook/site.yml |
|                                                                                  3. Запустить ansible-lint<br />для полученного playbook                                                                                  | Запущен ansible-lint. Исправлены ошибки                                                                                                                                                                                                                                               | ![1730763406239](image/README/1730763406239.png)                                              |
|                                                                                4. Попробовать запустить playbook<br />с флагом --check                                                                                | Команда была запущена уже<br />после успешного проигрывания <br />playbook.                                                                                                                                                                                  | ![1730763502561](image/README/1730763502561.png)                                              |
|                                                          5. Запустить playbook с<br />флагом --diff и убедиться, что<br />playbook идемпотентен                                                          | Команда была запущена уже после<br />успешного проигрывания<br />playbook.<br />Установлено, что playbook идемпотентен.<br />Изменения в данном случае - это <br />обновление кэша apt-get. | ![1730763629843](image/README/1730763629843.png)                                              |
|                                                                   6. Подготовить отдельный README<br />файл, в котором описать playbook.                                                                   | Подготовлен файл README для playbook-а                                                                                                                                                                                                                                                    | С файлом можно ознакомиться /src/playbook/README.md                 |