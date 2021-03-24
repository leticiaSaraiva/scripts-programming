#!/bin/bash

sudo apt-get update
sudo apt-get install -y mysql-client

echo "[client]
user=usuario
password=senha" > /root/.my.cnf

mysql --defaults-file=/root/.my.cnf -u usuario scripts -h ip_banco << EOF
USE scripts;
CREATE TABLE teste ( atividade INT );
EOF
