CREATE DATABASE jpashop;

CREATE USER 'repluser'@'%' IDENTIFIED WITH mysql_native_password BY 'repl1234';
GRANT REPLICATION SLAVE ON *.* TO 'repluser'@'%';