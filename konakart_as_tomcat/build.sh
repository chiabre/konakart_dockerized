#!/bin/bash

KONAKART_VERSION="9.6.0.0"
JMX_EXPORTER_VERSION="0.18.0"
JVM_VERSION="17"
IMG_VERSION="0.2"

docker build --no-cache --progress=plain --build-arg KONAKART_VERSION=${KONAKART_VERSION} --build-arg JMX_EXPORTER_VERSION=${JMX_EXPORTER_VERSION} --build-arg JVM_VERSION=${JVM_VERSION} -t "chiabre/konakart_as_tomcat:${KONAKART_VERSION}-${JVM_VERSION}-${IMG_VERSION}" .
