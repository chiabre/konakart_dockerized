# Docker images to run Konakart Community Edition demo

Dockers image to run the Konakart Community Edition J2EE demo application supporting Prometheus metrics

**Konakart Community Edition** : a java based shopping cart software solution for ocnline retailers. https://www.konakart.com/. ***Official [KonaKart Community Edition images](https://hub.docker.com/r/konakart)***

**Prometheus**: a free software application used for event monitoring and alerting. It records real-time metrics in a time series database built using a HTTP pull model, with flexible queries and real-time alerting. https://prometheus.io/

Available images:
* `konakart_as_tomcat`: Konakart Application Server running on Tomcat, additional info [here](/konakart_as_tomcat/README.md)  
* `konakart_db_mysql`: Konakart Community Edition database (demo data) running on MySQL, additional info [here](/konakart_db_mysql/README.md)  
* `konakart_db_postgres`: Konakart Community Edition database (demo data) running on PosgreSQL, additional info [here](/konakart_db_postgres/README.md)  

## Konakart deploy

By default the konakart application server provided by konakart_as_tomcat connects to a mysql database using the following parameters 

```properties
torque.database.store1.adapter=mysql
torque.dsfactory.store1.connection.driver=com.mysql.jdbc.Driver
torque.dsfactory.store1.connection.url=jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior\=convertToNull\&useSSL\=false
torque.dsfactory.store1.connection.user=konakart
torque.dsfactory.store1.connection.password=konakart
```

that are intended to be used for an OOB deployment based on the following deployment options

### Docker run

```console
docker run --rm -d --name konakart_db_mysql -p 3306:3306/tcp chiabre/konakart_db_mysql
docker run --rm -d --name konakart_as -p 9404:9404/tcp -p 8780:8780/tcp chiabre/konakart_as_tomcat
```
konakart overlay network has to be configured upfront using

```console
docker network create -d overlay --attachable konakart
```

Additional information on how to configure the Konakart AS to use a different database configuration [here](/konakart_as_tomcat/README.md)  
