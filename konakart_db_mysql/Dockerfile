ARG MYSQL_VERSION="8.0.24"

FROM mysql:${MYSQL_VERSION}

ARG KONAKART_VERSION="9.4.0.1"

LABEL maintainer="luca.chiabrera@gmail.com"

ENV MYSQL_DATABASE konakart
ENV MYSQL_USER konakart
ENV MYSQL_PASSWORD konakart
ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

COPY konakart_demo_${KONAKART_VERSION}.sql /docker-entrypoint-initdb.d/konakart_demo.sql
COPY my.cnf /etc/mysql/conf.d