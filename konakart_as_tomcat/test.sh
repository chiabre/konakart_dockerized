#!/bin/bash

docker run --rm -d --name konakart_as --net=akamas_lab -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat:9.4.0.1-java16


docker run -d -v ${PWD}/konakartadmin.properties:/opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties -v ${PWD}/konakart.properties:/opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties --name konakart_as --net=akamas_lab -p 9404:9404/tcp -p 8780:8780/tcp -e DB_SERVER="konakart_db_mysql" chiabre/konakart_as_tomcat:9.4.0.1-java11


#docker run --rm -d --name konakart_as_postgres --net=akamas_lab -p 9404:9404/tcp -p 8780:8780/tcp -e DB_ADAPTER="postgresql" -e DB_SERVER="konakart_db_postgres" -e DB_PORT="5432" -e DB_URL="jdbc:${DB_ADAPTER}://${DB_SERVER}:${DB_PORT}/${DB_NAME}" chiabre/konakart_as_jmx_exporter:9.4.0.1-java11
