FROM alpine:3.21

RUN apk update && apk upgrade && \
    apk add --no-cache curl tar php83 php83-fpm php83-mysqli php83-phar php83-mbstring \
    mariadb mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Install WordPress
RUN mkdir -p /var/www/html \
 && curl -fsSL https://wordpress.org/latest.tar.gz -o /tmp/wp.tgz \
 && tar -xzf /tmp/wp.tgz -C /tmp \
 && cp -r /tmp/wordpress/* /var/www/html/ \
 && rm -rf /tmp/wp.tgz /tmp/wordpress \
 && sed -ri 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf || true

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]