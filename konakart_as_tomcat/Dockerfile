ARG JAVA_VERSION="11"
ARG JAVA_JVM=""

FROM adoptopenjdk/openjdk${JAVA_VERSION}${JAVA_JVM}:alpine-jre

LABEL maintainer="luca.chiabrera@gmail.com"

ARG KONAKART_VERSION="9.4.0.1"
ENV KONAKART_DOWNLOAD_URL https://www.konakart.com/kits/${KONAKART_VERSION}/KonaKart-${KONAKART_VERSION}-Linux-Install-64

ARG JMX_EXPORTER_VERSION="0.15.0"
ENV JMX_EXPORTER_DOWNLOAD_URL https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar

ENV JAVA_OPTS "-Xmx1400m -Xms400m" 

ENV DB_ADAPTER mysql
ENV DB_DRIVER com.mysql.jdbc.Driver
ENV DB_URL "jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior=convertToNull&useSSL=false"
ENV DB_USER konakart
ENV DB_PWD konakart

RUN apk update \
    && apk upgrade \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add --no-cache \
    curl \
    && rm -rf /var/cache/apk/* \ 
    && mkdir -p /opt/jmx-exporter/ \
    && curl --location --silent --show-error --output /opt/jmx-exporter/jmx_prometheus_javaagent.jar ${JMX_EXPORTER_DOWNLOAD_URL} \
    && curl --location --silent --show-error --output /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 ${KONAKART_DOWNLOAD_URL} \
    && chmod +x /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 \  
    && /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 -S \
        -DJavaJRE ${JAVA_HOME} \
        -DDatabaseType ${DB_ADAPTER} \
        -DDatabaseDriver ${DB_DRIVER} \
        -DDatabaseUrl ${DB_URL} \
        -DDatabaseUsername ${DB_USER} \
        -DDatabasePassword ${DB_PWD} \
        -DLoadDB 0 \
        -DInstallationDir /opt/konakart/ \
    && rm /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 

# database properties files
COPY db/konakartadmin.properties /opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties
COPY db/konakart.properties /opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties

# jmx exporter config
COPY jmx_exporter_config.yml /opt/jmx-exporter/config.yml

#custom startup script
COPY startkonakart_${KONAKART_VERSION}.sh /opt/konakart/bin/startkonakart.sh 

EXPOSE 9404
EXPOSE 8780

HEALTHCHECK CMD curl --fail-with-body http://localhost:8780/konakart/Welcome.action | grep -q "<title>KonaKart</title>" || exit 1  

CMD sh /opt/konakart/bin/startkonakart.sh

