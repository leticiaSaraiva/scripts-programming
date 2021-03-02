#!/bin/bash

sudo apt-get update
sudo apt install apache2 -y

echo "<!doctype html><html><body><h2>Leticia, 402120</h2></body></html>" >  /var/www/html/index.html
