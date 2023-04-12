#!/bin/bash


##MYSQL
docker network create -d overlay --attachable konakart
docker run --rm -d --name konakart_db_mysql --net konakart -p 3306:3306/tcp chiabre/konakart_db_mysql
sleep 120
# docker run --rm -d --name konakart_as --net konakart -e DB_ADAPTER="mysql" -e DB_DRIVER="com.mysql.cj.jdbc.Driver" -e DB_URL="jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior=convertToNull&useSSL=false" -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat
docker run --rm -d --name konakart_as --net konakart -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat


##POSTGRES
# docker network create -d overlay --attachable konakart
# docker run --rm -d --name konakart_db_postgres --net konakart -p 5432:5432/tcp chiabre/konakart_db_postgres
# sleep 60
# docker run --rm -d --name konakart_as --net konakart -e DB_ADAPTER="postgresql" -e DB_DRIVER="org.postgresql.Driver" -e DB_URL="jdbc:postgresql://konakart_db_postgres:5432/konakart" -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat



