#!/bin/bash

docker run --rm -d --name konakart_db_postgres --net=akamas_lab -p 5432:5432/tcp chiabre/konakart_db_postgres:9.4.0.1_13.2

#docker run --rm -d --name mysqld_exporter --net=akamas_lab -p 9104:9104 -e DATA_SOURCE_NAME="exporter_usr:exporter_pwd@(konakart_db_mysql:3306)/konakart" prom/mysqld-exporter
#docker run --rm -d --name mysqld_exporter --net=akamas_lab -p 9104:9104 -e DATA_SOURCE_NAME="root@(konakart_db:3306)/konakart" prom/mysqld-exporter