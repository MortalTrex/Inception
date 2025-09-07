FROM alpine:3.21

RUN apk add --no-cache nginx openssl

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/ssl /etc/nginx/ssl
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 443
ENTRYPOINT ["/entrypoint.sh"]
