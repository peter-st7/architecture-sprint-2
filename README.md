# Проектная работа спринта 2

## Задание 1, 5, 6
Структурная диаграмма системы - [Scheme.drawio](./Scheme.drawio)

## Задание 2. Шардирование
Проект разворачивает следующие компоненты:
- БД сервер Mongo `mongod --shardsvr`, 2 шарда по 1 экземпляру в каждом.
- Конфигурационный сервер Mongo `mongod --configsvr`, 3 экземпляра.
- Сервис роутинга запросов к БД Mongo `mongos`, 1 экземпляр.
- Приложение `pymongo_api`, 1 экземпляр.

Команды для инициализации проекта и проверки результата:
```sh
# Выполнить в директории ./mongo-sharding
docker compose up -d
chmod 700 mongo-init.sh
./mongo-init.sh
curl "http://localhost:8080/helloDoc/count"
```

## Задание 3. Репликация
Проект разворачивает следующие компоненты:
- БД сервер Mongo `mongod --shardsvr`, 2 шарда по 3 реплики в каждом.
- Конфигурационный сервер Mongo `mongod --configsvr`, 3 экземпляра.
- Сервис роутинга запросов к БД Mongo `mongos`, 1 экземпляр.
- Приложение `pymongo_api`, 1 экземпляр.

Команды для инициализации проекта и проверки результата:
```sh
# Выполнить в директории ./mongo-sharding
docker compose up -d
chmod 700 mongo-init.sh
./mongo-init.sh
curl "http://localhost:8080/helloDoc/count"
```