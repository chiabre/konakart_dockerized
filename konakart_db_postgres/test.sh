#!/bin/bash

docker run --rm -d --name konakart_db_postgres -p 5432:5432/tcp chiabre/konakart_db_postgres:9.4.0.1_13.2

# postgres exporter
docker run --net=akamas_lab -p 9187:9187/tcp -e DATA_SOURCE_NAME="postgresql://konakart:konakart@konakart_db_postgres:5432/konakart?sslmode=disable" quay.io/prometheuscommunity/postgres-exporter
