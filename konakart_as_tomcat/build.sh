#!/bin/bash

KONAKART_VERSION="9.4.0.1"

JMX_EXPORTER_VERSION="0.15.0"

IMG_VERSION="0.1"

for JAVA_VERSION in 8 11
do
    for JAVA_JVM in "" "-openj9"
    do
        docker build --build-arg JAVA_VERSION=${JAVA_VERSION} --build-arg JAVA_JVM=${JAVA_JVM} --build-arg KONAKART_VERSION=${KONAKART_VERSION} --build-arg JMX_EXPORTER_VERSION=${JMX_EXPORTER_VERSION} -t "chiabre/konakart_as_tomcat:${KONAKART_VERSION}-java${JAVA_VERSION}${JAVA_JVM}-${IMG_VERSION}" .
        docker push "chiabre/konakart_as_tomcat:${KONAKART_VERSION}-java${JAVA_VERSION}${JAVA_JVM}-${IMG_VERSION}"
    done
done