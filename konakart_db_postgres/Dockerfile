ARG POSTGRES_VERSION="13.2"

FROM postgres:${POSTGRES_VERSION}

ARG KONAKART_VERSION="9.4.0.1"

LABEL maintainer="luca.chiabrera@gmail.com"

ENV POSTGRES_DB konakart
ENV POSTGRES_USER konakart
ENV POSTGRES_PASSWORD konakart

COPY konakart_demo_${KONAKART_VERSION}.sql /docker-entrypoint-initdb.d/konakart_demo.sql
#COPY my.cnf /etc/mysql/conf.d