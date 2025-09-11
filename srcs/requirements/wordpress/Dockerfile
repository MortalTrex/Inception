FROM alpine:3.21

RUN apk update && apk upgrade && apk add --no-cache curl \
    php83 php83-fpm php83-mysqli php83-phar php83-iconv php83-mbstring

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp-cli.phar

RUN mkdir -p /var/www/html

RUN curl -O --output-dir /tmp https://wordpress.org/latest.tar.gz

RUN mkdir -p /var/www/html

RUN tar -xzvf /tmp/latest.tar.gz -C /var/www/html

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf

RUN chmod 755 /etc/php83/php-fpm.d/www.conf

EXPOSE 9000

COPY ./tools/entrypoint.sh ./
RUN chmod +x ./entrypoint.sh


RUN chmod 755 /etc/php83/php-fpm.d/www.conf

RUN ln -sf /usr/bin/php83 /usr/bin/php

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["sh", "/entrypoint.sh"]