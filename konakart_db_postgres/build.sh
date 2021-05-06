#!/bin/bash

POSTGRES_VERSION="13.2"
KONAKART_VERSION="9.4.0.1"

docker build --build-arg KONAKART_VERSION=${KONAKART_VERSION} --build-arg MYSQL_VERSION=${POSTGRES_VERSION} -t "chiabre/konakart_db_postgres:${KONAKART_VERSION}_${POSTGRES_VERSION}" .
