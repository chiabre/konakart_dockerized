# Docker image for Konakart Community Edition demo postgreSQL server

Docker image to run the Konakart Community Edition postgreSQL server already configured to expose postgreSQL metrics to Prometheus.

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

* Konakart Community Edition 9401, postgreSQL 13.2
   * `latest`, `9.4.0.1-13.2`

## How to use this image

### Build

```bash
build.sh
```

### Run

#### Konakart 13.2 server

```bash
docker run --rm -d --name konakart_db_postgres -p 3306:3306/tcp chiabre/konakart_db_postgres
```

#### 13.2 Server Exporter 

```bash
docker run --net=akamas_lab -p 9187:9187/tcp -e DATA_SOURCE_NAME="postgresql://konakart:konakart@konakart_db_postgres:5432/konakart?sslmode=disable" quay.io/prometheuscommunity/postgres-exporter
```