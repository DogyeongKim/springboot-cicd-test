#!/bin/bash

docker-compose down

master_exist=`docker ps | grep mysqlMaster`
slave1_exist=`docker ps | grep mysqlSlave1`
slave2_exist=`docker ps | grep mysqlSlave2`

if [ -z ${master_exist} ]&&[ -z ${slave1_exist} ]&&[ -z ${slave2_exist} ]
then
   echo "docker-compose Successfully Down"
else
   echo "docker-compose Down Fail!"

fi