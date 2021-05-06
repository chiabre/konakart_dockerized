#!/bin/bash

docker run --rm -d --name konakart_as -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat:9.4.0.1-java16

## postgres db
## docker run --rm -d --name konakart_as -v ${PWD}/postgres/konakartadmin.properties:/opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties -v ${PWD}/postgres/konakart.properties:/opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat:9.4.0.1-java11
