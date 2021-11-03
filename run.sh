#!/bin/bash

docker-compose -f ./docker-compose.yml up -d

sleep 5

master_log_file=`mysql -h127.0.0.1 --port 33060 -uroot -proot1234 -e "show master status\G" | grep mysql-bin`
master_log_file=${master_log_file}

master_log_file=${master_log_file//[[:blank:]]/}

#master_log_file=${${master_log_file}#File:}
master_log_file=${master_log_file:5}

echo "File:${master_log_file}"



master_log_pos=`mysql -h127.0.0.1 --port 33060  -uroot -proot1234 -e "show master status\G" | grep Position`
master_log_pos=${master_log_pos}

master_log_pos=${master_log_pos//[[:blank:]]/}

#master_log_pos=${${master_log_pos}#Position:}
master_log_pos=${master_log_pos:9}

echo "Position:${master_log_pos}"


query="CHANGE MASTER TO MASTER_HOST='mysqlMaster', MASTER_USER='repluser', MASTER_PASSWORD='repl1234', MASTER_LOG_FILE='${master_log_file}', MASTER_LOG_POS=${master_log_pos};  "

mysql -h127.0.0.1 --port 33061 -uroot -proot1234 -e "stop slave"
mysql -h127.0.0.1 --port 33061 -uroot -proot1234 -e "reset slave"
mysql -h127.0.0.1 --port 33061 -uroot -proot1234 -e "${query}"
mysql -h127.0.0.1 --port 33061 -uroot -proot1234 -e "start slave"


mysql -h127.0.0.1 --port 33062 -uroot -proot1234 -e "stop slave"
mysql -h127.0.0.1 --port 33062 -uroot -proot1234 -e "reset slave"
mysql -h127.0.0.1 --port 33062 -uroot -proot1234 -e "${query}"
mysql -h127.0.0.1 --port 33062 -uroot -proot1234 -e "start slave"