#!/bin/bash

sudo apt-get update
sudo apt-get install -y mysql-server

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

systemctl restart mysql.service 

mysql<<EOF
CREATE DATABASE scripts;
CREATE USER 'usuario'@'%' IDENTIFIED BY 'senha';
GRANT ALL PRIVILEGES ON scripts.* TO 'usuario'@'%';
EOF
