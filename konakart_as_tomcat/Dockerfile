ARG JAVA_VERSION="11"
ARG JAVA_JVM=""

FROM adoptopenjdk/openjdk${JAVA_VERSION}${JAVA_JVM}:alpine-jre

LABEL maintainer="luca.chiabrera@gmail.com"

ARG JMX_EXPORTER_VERSION="0.15.0"
ENV JMX_EXPORTER_DOWNLOAD_URL https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar

ARG KONAKART_VERSION="9.4.0.1"
ENV KONAKART_DOWNLOAD_URL https://www.konakart.com/kits/${KONAKART_VERSION}/KonaKart-${KONAKART_VERSION}.zip 


ENV JAVA_OPTS "-Xmx1400m -Xms400m" 


RUN apk update \
    && apk upgrade \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add --no-cache \
    unzip \
    curl \
    && rm -rf /var/cache/apk/* \ 
    && mkdir -p /opt/jmx-exporter/ \
    && curl --location --silent --show-error --output /opt/jmx-exporter/jmx_prometheus_javaagent.jar ${JMX_EXPORTER_DOWNLOAD_URL} \
    && curl --location --silent --show-error --output /tmp/KonaKart.zip ${KONAKART_DOWNLOAD_URL} \    
    && unzip -qq /tmp/KonaKart.zip -d /opt/ \
    && rm /tmp/KonaKart.zip \
    && sh /opt/konakart/custom/copyDuplicates.sh /opt/konakart \
    && chmod +x /opt/konakart/bin/*.sh

# database properties files
COPY mysql/konakartadmin.properties /opt/konakart/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties
COPY mysql/konakart.properties /opt/konakart/webapps/konakart/WEB-INF/classes/konakart.properties

# jmx exporter config
COPY jmx_exporter_config.yml /opt/jmx-exporter/config.yml

#custom startup script
COPY startkonakart_${KONAKART_VERSION}.sh /opt/konakart/bin/startkonakart.sh 

EXPOSE 9404
EXPOSE 8780

HEALTHCHECK CMD curl --fail-with-body http://localhost:8780/konakart/Welcome.action | grep -q "<title>KonaKart</title>" || exit 1  

CMD sh /opt/konakart/bin/startkonakart.sh

