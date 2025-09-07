FROM alpine:3.21

RUN apk add --no-cache curl \
    php83 php83-fpm php83-mysqli php83-phar php83-iconv php83-mbstring

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html \
 && curl https://wordpress.org/latest.tar.gz \
 | tar -xz -C /var/www/html \
 && sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf


COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]