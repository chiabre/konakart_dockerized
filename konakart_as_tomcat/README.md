# Docker image for Konakart Community Edition demo Application server+ JMX to Prometheus exporter

Docker image to run the Konakart Community Edition J2EE tomcat application server exposing JMX to Prometheus exporter metrics and java options as env. variables.

**Konakart Community Edition** : a java based shopping cart software solution for online retailers. https://www.konakart.com/. ***Official [KonaKart Community Edition images](https://hub.docker.com/r/konakart)***

**JMX to Prometheus exporter**: a collector that can configurably scrape and expose mBeans of a JMX target. https://github.com/prometheus/jmx_exporter

The **version number** of this images is composed of two version numbers
  * the first is the version of the Konakart Community Edition 
  * the second is the Java version and Java JVM (hotspot or openj9) 

## KonaKart Community Edition demo + JMX to Prometheus exporter

`konakart_as_tomcat`

* Find Images of this repo on [docker hub](https://hub.docker.com/repository/docker/chiabre/konakart_as_tomcat)
* Find repo of this images on [github](https://github.com/chiabre/konakart_dockerized/konakart_as_tomcat)

In addition to the standard [Konakart Community Edition](https://www.konakart.com/downloads/community_edition/) tomcat set-up:
* JMX to Prometheus exporter metrics on port 9404
* JVM_OPTS as ENV. variable (dafeult JAVA_OPTS="-Xmx1400m -Xms400m")

### Supported tags

* Konakart Community Edition 9401, Java 11 hotspot, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15
   * `latest`, `9.4.0.1-java11`
* Konakart Community Edition 9401, Java 11 openj9, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15
   * `9.4.0.1-java11-openj9`
* Konakart Community Edition 9401, Java16 hotspot, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15
   * `9.4.0.1-java16`
* Konakart Community Edition 9401, Java 16 openj9, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15
   * `9.4.0.1-java16-openj9`
* Konakart Community Edition 9401, Java 8 hotspot, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15
   * `9.4.0.1-java8`
* Konakart Community Edition 9401, Java 8 openj9, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15
   * `9.4.0.1-java8-openj9`

## How to use this image

### Build

```bash
build.sh
```

### Deploy

The Konakart Community Edition provided in this image requires an external database to be executed. 

To ease the Konakart deployment this repo provides 2 database images:

* `konakart_db_mysql`: Konakart Community Edition database running on MySQL, additional info [here](/konakart_db_mysql/README.md)  
* `konakart_db_postgres`: Konakart Community Edition database running on PosgreSQL, additional info [here](/konakart_dockerized/konakart_db_postgres/README.md)  

To use custom the `JVM_OPTS` use the `JAVA_OPTS` ENV. variable

#### konakart_db_mysql

By default this image use the following database connections parameters: 

* url = `jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior=convertToNull&useSSL=false`
* user = `konakart`
* password = `konakart`

that are intended to be used for an OOB deployment based on the following deployment options

##### Docker run

```console
docker run --rm -d --name konakart_db_mysql -p 3306:3306/tcp chiabre/konakart_db_mysql:latest
docker run --rm -d --name konakart_as -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat:latest
```

##### Docker-compose

```yaml
version: "3.8"
services:
  konakart_as:
    image: chiabre/konakart_as_tomcat:latest
    ports:
    - 9404:9404 #jmx_exporter
    - 8780:8780 #UI
    - 8783:8783 #Admin UI
    networks: 
      - konakart
  konakart_db_mysql:
    image: chiabre/konakart_db_mysql:latest
    networks: 
      - konakart

networks:
  konakart:
    external: true
    name: konakart
```

konakart overlay network has to be configured upfront using

```console
docker network create -d overlay --attachable konakart
```

#### konakart_db_postgres

##### Docker run

```console
docker run --rm -d --name konakart_db_postgres -p 5432:5432/tcp chiabre/konakart_db_postgres:9.4.0.1_13.2
docker run --rm -d --name konakart_as -v ${PWD}/postgres/konakartadmin.properties:/opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties -v ${PWD}/postgres/konakart.properties:/opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat:9.4.0.1-java11
```

##### Docker-compose

```yaml
version: "3.8"
services:
  konakart_as:
    image: chiabre/konakart_as_tomcat:latest
    ports:
    - 9404:9404 #jmx_exporter
    - 8780:8780 #UI
    - 8783:8783 #Admin UI
    networks: 
      - konakart
    volumes:
    - ./postgres/konakart.properties:/opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties:ro
    - ./postgres/konakartadmin.properties:/opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties:ro
  konakart_db_mysql:
    image: chiabre/konakart_db_mysql:latest
    networks: 
      - konakart

networks:
  konakart:
    external: true
    name: konakart
```

konakart overlay network has to be configured upfront using

```console
docker network create -d overlay --attachable konakart
```

#### custom database 

To connect to a different database: 

1. set- as per [Konakart documentation] (https://www.konakart.com/docs/DatabaseNotes.html) - the connections parameters in the `konakart.properties` and `konakartadmin.properties` files (samples of mysql and postres configurations provided the mysql and posgres folders).
2. mount the 2 file in the following directory:
    * `konakart.properties` -> `/opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties`
    * `konakartadmin.properties` ->  `/opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties`


### Operate

Konakart store ui will be available on port `8780`:

* http://[KONAKART_SERVER]:8780

Prometheus JMX exporter metrics will be available on port `9404`:

* http://[KONAKART_SERVER]:9404/metrics/

Konakart admin ui will be available at the following url:

* http://[KONAKART_SERVER]:8780/konakartadmin/

(login using "admin@konakart.com" as the username and "princess" as the password)

