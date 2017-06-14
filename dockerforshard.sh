#!/bin/bash

docker rm rs1_srv1
docker rm rs1_srv2
docker rm rs1_srv3
docker rm rs2_srv3
docker rm rs2_srv2
docker rm rs2_srv1
docker rm cfg1
docker rm cfg2
docker rm cfg3
docker rm mongos1




sudo docker run \
  -P --name rs1_srv1 \
  -d dev24/mongodb \
  --replSet rs1 \
  --noprealloc --smallfiles



sudo docker run \
  -P --name rs1_srv2 \
  -d dev24/mongodb \
  --replSet rs1 \
  --noprealloc --smallfiles


  sudo docker run \
  -P --name rs1_srv3 \
  -d dev24/mongodb \
  --replSet rs1 \
  --noprealloc --smallfiles



  sudo docker run \
  -P --name rs2_srv1 \
  -d dev24/mongodb \
  --replSet rs2 \
  --noprealloc --smallfiles


sudo docker run \
  -P --name rs2_srv2 \
  -d dev24/mongodb \
  --replSet rs2 \
  --noprealloc --smallfiles

  sudo docker run \
  -P --name rs2_srv3 \
  -d dev24/mongodb \
  --replSet rs2 \
  --noprealloc --smallfiles

docker inspect rs1_srv1

rs.initiate()
rs.add("172.17.0.3:27017")
rs.add("172.17.0.4:27017")



cfg = rs.conf()
cfg.members[0].host = "172.17.0.2:27017"
rs.reconfig(cfg)
rs.status()




sudo docker run \
  -P --name rs2_srv1 \
  -d dev24/mongodb \
  --replSet rs2 \
  --noprealloc --smallfiles


sudo docker run \
  -P --name rs2_srv2 \
  -d dev24/mongodb \
  --replSet rs2 \
  --noprealloc --smallfiles

  sudo docker run \
  -P --name rs2_srv3 \
  -d dev24/mongodb \
  --replSet rs2 \
  --noprealloc --smallfiles



docker inspect rs2_srv1



rs.initiate()
rs.add("172.17.0.6:27017")
rs.add("172.17.0.7:27017")
rs.status()

cfg = rs.conf()
cfg.members[0].host = "172.17.0.5:27017"
rs.reconfig(cfg)
rs.status()



sudo docker run \
  -P --name cfg1 \
  -d dev24/mongodb \
  --noprealloc --smallfiles \
  --configsvr \
  --dbpath /data/db \
  --port 27017

sudo docker run \
  -P --name cfg2 \
  -d dev24/mongodb \
  --noprealloc --smallfiles \
  --configsvr \
  --dbpath /data/db \
  --port 27017

sudo docker run \
  -P --name cfg3 \
  -d dev24/mongodb \
  --noprealloc --smallfiles \
  --configsvr \
  --dbpath /data/db \
  --port 27017

  docker inspect cfg1

  cfg1 : 172.17.0.8
  cfg2 : 172.17.0.9

  cfg3 : 172.17.0.10



sudo docker run -P --name mongos1 -d dev24/mongos --port 27017 --configdb  172.17.0.8:27017,172.17.0.9:27017,172.17.0.10:27017



sh.addShard("rs1/172.17.0.2:27017")
sh.addShard("rs2/172.17.0.5:27017")
sh.status()
