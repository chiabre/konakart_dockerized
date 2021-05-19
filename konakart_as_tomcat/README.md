# Docker image for Konakart Community Edition Application server + JMX to Prometheus exporter

Docker image to run the Konakart Community Edition J2EE tomcat application server exposing JMX to Prometheus exporter metrics and java options as env. variables.

**Konakart Community Edition** : a java based shopping cart software solution for online retailers. https://www.konakart.com/.

**JMX to Prometheus exporter**: a collector that can configurably scrape and expose mBeans of a JMX target. https://github.com/prometheus/jmx_exporter

The **version number** of this images is composed of 3 version numbers:
  * the first is the version of the Konakart Community Edition 
  * the second is the Java version and Java JVM (hotspot or openj9) 
  * the third is the img version itself

## KonaKart Community Edition demo + JMX to Prometheus exporter

`konakart_as_tomcat`

* Find Images of this repo on [docker hub](https://hub.docker.com/repository/docker/chiabre/konakart_as_tomcat)
* Find repo of these images on [github](https://github.com/chiabre/konakart_dockerized/konakart_as_tomcat)

In addition to the standard [Konakart Community Edition](https://www.konakart.com/downloads/community_edition/) tomcat set-up:

* JMX to Prometheus exporter metrics on port 9404
* JVM_OPTS as env. variable
* a set of env. variables to ease the database configuration

### Supported tags

* Konakart Community Edition 9401, Java 11 hotspot, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via env. variables
   * `latest`, `9.4.0.1-java11-0.1`
* Konakart Community Edition 9401, Java 11 openj9, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via env. variables
   * `9.4.0.1-java11-openj9-0.1`
* Konakart Community Edition 9401, Java 8 hotspot, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via env. variables
   * `9.4.0.1-java8-0.1`
* Konakart Community Edition 9401, Java 8 openj9, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via env. variables
   * `9.4.0.1-java8-openj9-0.1`
* Konakart Community Edition 9401, Java 11 hotspot, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via file mount
   * `9.4.0.1-java11`
* Konakart Community Edition 9401, Java 11 openj9, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via file mount
   * `9.4.0.1-java11-openj9`
* Konakart Community Edition 9401, Java 8 hotspot, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via file mount
   * `9.4.0.1-java8`
* Konakart Community Edition 9401, Java 8 openj9, Tomcat 9.0.31.0, JMX to Prometheus exporter 0.15, db connection parameters via file mount
   * `9.4.0.1-java8-openj9`

## How to use this image (v0.1)

The Konakart Community Edition provided in this image requires an external database to be executed that can be easily connected thanks to the dedicated env. variables. 

To ease the Konakart deployment this repo provides the following pre-configure database images (konakart demo data):

* `konakart_db_mysql`: Konakart Community Edition database running on MySQL, additional info [here](/konakart_db_mysql/README.md)  
* `konakart_db_postgres`: Konakart Community Edition database running on PosgreSQL, additional info [here](/konakart_db_postgres/README.md)  

Custom `JVM_OPTS` can be set using the `JAVA_OPTS` env. variable  (dafeult "-Xmx1400m -Xms400m")

### konakart_db_mysql

By default this image uses the following database connections parameters: 

```properties
torque.database.store1.adapter=mysql
torque.dsfactory.store1.connection.driver=com.mysql.jdbc.Driver
torque.dsfactory.store1.connection.url=jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior\=convertToNull\&useSSL\=false
torque.dsfactory.store1.connection.user=konakart
torque.dsfactory.store1.connection.password=konakart
```
that are intended to be used for an OOB deployment based on the `chiabre/konakart_db_mysql` image

```console
docker run --rm -d --name konakart_db_mysql -p 3306:3306/tcp chiabre/konakart_db_mysql
docker run --rm -d --name konakart_as -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat
```
to modify one of the connections parameter refer to the custom database section

### konakart_db_postgres

To use the `konakart_db_postgres` img add the env. variables `DB_ADAPTER="postgresql"` and `DB_URL="jdbc:postgresql://konakart_db_postgres:5432/konakart"` to the docker run command as in the following example

```console
docker run --rm -d --name konakart_db_postgres -p 5432:5432/tcp chiabre/konakart_db_postgres
docker run --rm -d --name konakart_as -e DB_ADAPTER="postgresql" -e DB_URL="jdbc:postgresql://konakart_db_postgres:5432/konakart" -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat
```

### custom database 

As per [Konakart documentation] (https://www.konakart.com/docs/DatabaseNotes.html) the database connections parameter are managed in the `konakart.properties` and `konakartadmin.properties` files.

This the availabe env. variables:

* `DB_ADAPTER`
* `DB_URL`
* `DB_USER`
* `DB_PWD`

This how the above env. variables are applied n the `konakart.properties` and `konakartadmin.properties` files:

```properties
torque.database.store1.adapter             = ${env:DB_ADAPTER}
torque.dsfactory.store1.connection.driver  = com.${env:DB_ADAPTER}.jdbc.Driver
torque.dsfactory.store1.connection.url     = ${env:DB_URL}
torque.dsfactory.store1.connection.user    = ${env:DB_USER}
torque.dsfactory.store1.connection.password= ${env:DB_PWD}
```

### UI and metrics

Konakart store ui will be available on port `8780`:

* http://[KONAKART_SERVER]:8780

Prometheus JMX exporter metrics will be available on port `9404`:

* http://[KONAKART_SERVER]:9404/metrics/

Konakart admin ui will be available at the following url:

* http://[KONAKART_SERVER]:8780/konakartadmin/

(login using "admin@konakart.com" as the username and "princess" as the password)


## How to use this image (prior to v0.1)

The Konakart Community Edition provided in this image requires an external database to be executed. 

To ease the Konakart deployment this repo provides 2 database images:

* `konakart_db_mysql`: Konakart Community Edition database running on MySQL, additional info [here](/konakart_db_mysql/README.md)  
* `konakart_db_postgres`: Konakart Community Edition database running on PosgreSQL, additional info [here](/konakart_db_postgres/README.md)  

To use custom the `JVM_OPTS` use the `JAVA_OPTS` ENV. variable

### konakart_db_mysql

By default this image uses the following database connections parameters: 

* url = `jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior=convertToNull&useSSL=false`
* user = `konakart`
* password = `konakart`

that are intended to be used for an OOB deployment based on the following deployment options

```console
docker run --rm -d --name konakart_db_mysql -p 3306:3306/tcp chiabre/konakart_db_mysql
docker run --rm -d --name konakart_as -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat
```

### konakart_db_postgres

```console
docker run --rm -d --name konakart_db_postgres -p 5432:5432/tcp chiabre/konakart_db_postgres
docker run --rm -d --name konakart_as -v ${PWD}/postgres/konakartadmin.properties:/opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties -v ${PWD}/postgres/konakart.properties:/opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat
```

### custom database 

To connect to a different database: 

1. set- as per [Konakart documentation] (https://www.konakart.com/docs/DatabaseNotes.html) - the connections parameters in the `konakart.properties` and `konakartadmin.properties` files (samples of MySQL and postreSQL configurations provided the mysql and posgres folders).
2. mount the 2 files in the following directories:
    * `konakart.properties` -> `/opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties`
    * `konakartadmin.properties` ->  `/opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties`
