#!/bin/bash

docker run --rm -d --name konakart_db_mysql -p 3306:3306/tcp chiabre/konakart_db_mysql:9.4.0.1_8.0.24

# mysql exporter
docker run --rm -d --name mysqld_exporter -p 9104:9104 -e DATA_SOURCE_NAME="exporter_usr:exporter_pwd@(konakart_db_mysql:3306)/konakart" prom/mysqld-exporter
