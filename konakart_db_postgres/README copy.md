# Docker image for Konakart Community Edition demo + JMX to Prometheus exporter

Docker image to run the Konakart Community Edition J2EE demo application exposing JMX to Prometheus exporter metrics and java options as env. variables.

**Konakart Community Edition** : a java based shopping cart software solution for online retailers. https://www.konakart.com/. ***Official [KonaKart Community Edition images](https://hub.docker.com/r/konakart)***

**JMX to Prometheus exporter**: a collector that can configurably scrape and expose mBeans of a JMX target. https://github.com/prometheus/jmx_exporter

The **version number** of this images is composed of two version numbers
  * the first is the version of the Konakart Community Edition 
  * the second is the version of JMX to Prometheus exporter embedded in this docker image

## KonaKart Community Edition demo + JMX to Prometheus exporter

`chiabre/konkart_jmx_exporter`

* Find Images of this repo on [docker hub](https://hub.docker.com/repository/docker/chiabre/konakart_jmx_exporter)
* Find repo of this images on [github](https://github.com/chiabre/konakart_jmx_exporter)

In addition to the [official Konakart images](https://hub.docker.com/r/konakart):
* JMX to Prometheus exporter metrics on port 9404
* JVM_OPTS as ENV. variable (dafeult JAVA_OPTS="-Xmx1400m -Xms400m")

### Supported tags

* Konakart Community Edition 9400 (Java 11 and PostgreSQL 10) + JMX to Prometheus exporter 0.15
   * `latest`, `9400-0.15`
* Konakart Community Edition 9200 (Java 8 and PostgreSQL 9.4) + JMX to Prometheus exporter 0.15
   * `9200-0.15`

## How to use this image

### Build

```bash
build.sh
```

### Run

```bash
docker run -d -p 8780:8780 -p 9404:9404 chiabre/konkart_jmx_exporter
```

Konakart store ui will be available on port `8780`:

* http://[KONAKART_SERVER]:8780

Prometheus JMX exporter metrics will be available on port `9404`:

* http://[KONAKART_SERVER]:9404/metrics/

Konakart admin ui will be available at the following url:

* http://[KONAKART_SERVER]:8780/konakartadmin/

(login using "admin@konakart.com" as the username and "princess" as the password)

#### JVM_OPTS

To set the `JVM_OPTS` use the `JAVA_OPTS` ENV. variable as in the following example

```bash
docker run -d -p 8780:8780 -p 9404:9404 -e JAVA_OPTS="[YOUR JAVA OPTS]" chiabre/konkart_jmx_exporter`
```
