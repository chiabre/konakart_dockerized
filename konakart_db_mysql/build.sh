#!/bin/bash

MYSQL_VERSION="8.0.32"
KONAKART_VERSION="9.6.0.0"

docker build --no-cache --progress=plain --build-arg  KONAKART_VERSION=${KONAKART_VERSION} --build-arg MYSQL_VERSION=${MYSQL_VERSION} -t "chiabre/konakart_db_mysql:${KONAKART_VERSION}_${MYSQL_VERSION}" .
