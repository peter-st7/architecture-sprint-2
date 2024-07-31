# Проектная работа спринта 2

## Задание 1, 5, 6
Структурная диаграмма системы - [Scheme.drawio](./Scheme.drawio)

## Задание 2
Команды для инициализации проекта и проверки результата:
```sh
# Выполнить в директории ./mongo-sharding
docker compose up -d
chmod 700 mongo-init.sh
./mongo-init.sh
curl "http://localhost:8080/helloDoc/count"
```