#!/bin/bash

### Инициализация кластера конфиг. серверов ###
docker exec -it mongo_cfgrs_n1 mongosh --port 27091 --eval \
"rs.initiate({_id:'mongo_cfgrs', configsvr: true, \
members: [ \
  {_id:0, host:'mongo_cfgrs_n1:27091'}, \
  {_id:1, host:'mongo_cfgrs_n2:27092'}, \
  {_id:2, host:'mongo_cfgrs_n3:27093'} \
]});"

### Инициализация 1го шарда ###
docker exec -it mongo_dbrs_n1 mongosh --port 27011 --eval \
"rs.initiate({_id:'mongo_dbrs', \
members: [ \
  {_id:0, host:'mongo_dbrs_n1:27011'}, \
  {_id:1, host:'mongo_dbrs_n2:27012'}, \
  {_id:2, host:'mongo_dbrs_n3:27013'} \
]});"

### Инициализация 2го шарда ###
docker exec -it mongo_dbrs2_n1 mongosh --port 27021 --eval \
"rs.initiate({_id:'mongo_dbrs2', \
members: [ \
  {_id:0, host:'mongo_dbrs2_n1:27021'}, \
  {_id:1, host:'mongo_dbrs2_n2:27022'}, \
  {_id:2, host:'mongo_dbrs2_n3:27023'} \
]});"

sleep 15

### Инициализация роутера ###
docker exec -it mongo_router mongosh --port 27080 --eval "sh.addShard('mongo_dbrs/mongo_dbrs_n1:27011');"
docker exec -it mongo_router mongosh --port 27080 --eval "sh.addShard('mongo_dbrs2/mongo_dbrs2_n1:27021');"
docker exec -it mongo_router mongosh --port 27080 --eval "sh.enableSharding('somedb');"
docker exec -it mongo_router mongosh --port 27080 --eval "sh.shardCollection('somedb.helloDoc', {'name': 'hashed'});"

### Заполнение коллекции данными ###
docker exec -it mongo_router mongosh --port 27080 --eval 'for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})' somedb