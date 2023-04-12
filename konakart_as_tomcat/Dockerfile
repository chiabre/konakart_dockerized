ARG JVM_VERSION="17"

FROM eclipse-temurin:${JVM_VERSION}-jre-focal

LABEL maintainer="luca.chiabrera@gmail.com"

ARG KONAKART_VERSION="9.6.0.0"
ENV KONAKART_DOWNLOAD_URL https://www.konakart.com/kits/${KONAKART_VERSION}/KonaKart-${KONAKART_VERSION}-Linux-Install-64
ENV KONAKART_INSTALL_DIR="/opt/konakart"

ARG JMX_EXPORTER_VERSION="0.18.0"
ENV JMX_EXPORTER_DOWNLOAD_URL https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar
ENV JMX_EXPORTER_INSTALL_DIR="/opt/jmx-exporter"

ENV JAVA_OPTS "-Xmx1400m -Xms400m" 

ENV DB_ADAPTER mysql
ENV DB_DRIVER com.mysql.cj.jdbc.Driver
# ENV DB_DRIVER com.mysql.jdbc.Driver
ENV DB_URL "jdbc:mysql://konakart_db_mysql:3306/konakart?zeroDateTimeBehavior=convertToNull&useSSL=false"
# ENV DB_ADAPTER postgresql
# ENV DB_DRIVER org.postgresql.Driver
# ENV DB_URL "jdbc:postgresql://konakart_db_postgres:5432/konakart"
ENV DB_USER konakart
ENV DB_PWD konakart

RUN apt-get update \
    && apt-get install -y \
    apt-utils \
    ca-certificates \
    curl \
    coreutils \
    tzdata \
    bash \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/cache/apk/* \
    && mkdir -p ${KONAKART_INSTALL_DIR} \
    && mkdir -p ${JMX_EXPORTER_INSTALL_DIR}    

RUN  curl --location --show-error --output ${JMX_EXPORTER_INSTALL_DIR}/jmx_prometheus_javaagent.jar ${JMX_EXPORTER_DOWNLOAD_URL}

RUN  curl --location --show-error --output /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 ${KONAKART_DOWNLOAD_URL} 

RUN  chmod +x /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 

RUN  /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 -S \
        -DJavaJRE ${JAVA_HOME} \
        # -DDatabaseType ${DB_ADAPTER} \
        # -DDatabaseDriver ${DB_DRIVER} \
        # -DDatabaseUrl ${DB_URL} \
        -DDatabaseUsername ${DB_USER} \
        -DDatabasePassword ${DB_PWD} \
        -DLoadDB 0 \
        -DInstallationDir ${KONAKART_INSTALL_DIR} \
    && rm /tmp/KonaKart-${KONAKART_VERSION}-Linux-Install-64 

# database properties files
COPY db/konakartadmin.properties ${KONAKART_INSTALL_DIR}/webapps/konakartadmin/WEB-INF/classes/konakartadmin.properties
COPY db/konakart.properties ${KONAKART_INSTALL_DIR}/webapps/konakart/WEB-INF/classes/konakart.properties

# jmx exporter config
COPY jmx_exporter_config.yml ${JMX_EXPORTER_INSTALL_DIR}/config.yml

#custom startup script
COPY startkonakart_${KONAKART_VERSION}.sh ${KONAKART_INSTALL_DIR}/bin/startkonakart.sh

EXPOSE 9404
EXPOSE 8780

HEALTHCHECK CMD curl http://localhost:8780/konakart/Welcome.action | grep -q "<title>KonaKart</title>" || exit 1  

CMD sh ${KONAKART_INSTALL_DIR}/bin/startkonakart.sh && tail -F ${KONAKART_INSTALL_DIR}/logs/catalina.out

