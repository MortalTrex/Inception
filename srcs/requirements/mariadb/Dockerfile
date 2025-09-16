FROM alpine:3.21

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /etc/my.cnf.d && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./tools/entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
