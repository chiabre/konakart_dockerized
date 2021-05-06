# Docker image for Konakart Community Edition demo MySQL server

Docker image to run the Konakart Community Edition MySQL server already configured to expose MySQL metrics to Prometheus.

**Konakart Community Edition** : a java based shopping cart software solution for online retailers. https://www.konakart.com/.

**MySQL Server Exporter**: Prometheus exporter for MySQL. https://github.com/prometheus/MySQLd_exporter

The **version number** of this images is composed of two version numbers
  * the first is the version of the Konakart Community Edition 
  * the second is the MySQL database 

## KonaKart Community Edition demo  MySQL server

`konakart_db_mysql`

* Find Images of this repo on [docker hub](https://hub.docker.com/repository/docker/chiabre/konakart_db_mysql)
* Find repo of this images on [github](https://github.com/chiabre/konakart_dockerized/konakart_db_mysql)

In addition to the standard [Konakart Community Edition](https://www.konakart.com/downloads/community_edition/) MySQL set-up:
* user & grants already configured to expose metrics via MySQL Server Exporter


### Supported tags

* Konakart Community Edition 9401, MySQL 8.0.24
   * `latest`, `9.4.0.1-8.0.24`

## How to use this image

### Build

```bash
build.sh
```

### Run

#### Konakart MySQL server

```bash
docker run --rm -d --name konakart_db_mysql -p 3306:3306/tcp chiabre/konakart_db_mysql
```

#### MySQL Server Exporter 

```bash
docker run --rm -d --name mysqld_exporter -p 9104:9104 -e DATA_SOURCE_NAME="exporter_usr:exporter_pwd@(konakart_db_mysql:3306)/konakart" prom/mysqld-exporter
```