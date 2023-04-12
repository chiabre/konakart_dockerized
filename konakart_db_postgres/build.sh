#!/bin/bash

POSTGRES_VERSION="15.2"
KONAKART_VERSION="9.6.0.0"

docker build --no-cache --progress=plain --build-arg  KONAKART_VERSION=${KONAKART_VERSION} --build-arg POSTGRES_VERSION=${POSTGRES_VERSION} -t "chiabre/konakart_db_postgres:${KONAKART_VERSION}_${POSTGRES_VERSION}" .
