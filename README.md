# Docker images to run Konakart Community Edition demo

Dockers image to run the Konakart Community Edition J2EE demo application supporting Prometheus metrics

**Konakart Community Edition** : a java based shopping cart software solution for ocnline retailers. https://www.konakart.com/. ***Official [KonaKart Community Edition images](https://hub.docker.com/r/konakart)***

**Prometheus**: a free software application used for event monitoring and alerting. It records real-time metrics in a time series database built using a HTTP pull model, with flexible queries and real-time alerting. https://prometheus.io/

Available images:
* `konakart_as_tomcat`: Konakart Application Server running on Tomcat, additional info [here](/konakart_as_tomcat/README.md)  
* `konakart_db_mysql`: Konakart Community Edition database running on MySQL, additional info [here](/konakart_dockerized/konakart_db_mysql/README.md)  
* `konakart_db_postgres`: Konakart Community Edition database running on PosgreSQL, additional info [here](/konakart_dockerized/konakart_db_postgres/README.md)  

## Konakart deploy

By default the konakart application server provided by konakart_as_tomcat connects to a mysql database using the following parameters 

* url = `jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior=convertToNull&useSSL=false`
* user = `konakart`
* password = `konakart`

that are intended to be used for an OOB deployment based on the following deployment options

### Docker run

```console
docker run --rm -d --name konakart_db_mysql -p 3306:3306/tcp chiabre/konakart_db_mysql:latest
docker run --rm -d --name konakart_as -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat:latest
```

### Docker-compose

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

Additional information on how to configure the Konakart AS to use a different database configuration [here](/konakart_dockerized/konakart_as_tomcat/README.md)  
