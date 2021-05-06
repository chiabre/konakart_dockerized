#!/bin/bash

MYSQL_VERSION="8.0.24"
KONAKART_VERSION="9.4.0.1"

docker build --build-arg KONAKART_VERSION=${KONAKART_VERSION} --build-arg MYSQL_VERSION=${MYSQL_VERSION} -t "chiabre/konakart_db_mysql:${KONAKART_VERSION}_${MYSQL_VERSION}" .
