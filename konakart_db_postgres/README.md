# Docker image for Konakart Community Edition postgreSQL server (demo data)

Docker image to run the Konakart Community Edition postgreSQL server already configured to expose postgreSQL metrics to Prometheus and loaded with demo data.

**Konakart Community Edition** : a java based shopping cart software solution for online retailers. https://www.konakart.com/.

**Prometheus Monitoring Community PostgreSQL Exporter**: Prometheus exporter for postgreSQL. https://github.com/prometheus-community/postgres_exporter

The **version number** of this images is composed of two version numbers
  * the first is the version of the Konakart Community Edition 
  * the second is the postgreSQL database 

## KonaKart Community Edition demo  postgreSQL server

`konakart_db_postgres`

* Find Images of this repo on [docker hub](https://hub.docker.com/repository/docker/chiabre/konakart_db_postgres)
* Find repo of this images on [github](https://github.com/chiabre/konakart_dockerized/konakart_db_postgres)

In addition to the standard [Konakart Community Edition](https://www.konakart.com/downloads/community_edition/) postgreSQL set-up:
* user & grants already configured to expose metrics via postgreSQL Exporter


### Supported tags

* Konakart Community Edition 9600, postgreSQL 15.2
   * `latest`, `9.6.0.1-15.2`
* Konakart Community Edition 9600, postgreSQL 13.8  
   * `9.6.0.0-13.8`
* Konakart Community Edition 9401, postgreSQL 13.2
   * `9.4.0.1-13.2`

## How to use this image

### Build

```bash
build.sh
```

### Run

#### PostgreSQL Konakart Server

```bash
docker network create -d overlay --attachable konakart
docker run --rm -d --name konakart_db_postgres --net konakart -p 3306:3306/tcp chiabre/konakart_db_postgres
```

#### Prometheus Monitoring Community PostgreSQL Exporter

```bash
docker run --d -name postgres_exporter --net konakart -p 9187:9187/tcp -e DATA_SOURCE_NAME="postgresql://konakart:konakart@konakart_db_postgres:5432/konakart?sslmode=disable" quay.io/prometheuscommunity/postgres-exporter
```