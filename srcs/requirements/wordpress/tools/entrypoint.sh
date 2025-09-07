#!/bin/sh
set -e

cd /var/www/html

echo "Waiting for MariaDB to be ready..."

until mariadb-admin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" >/dev/null 2>&1; do
  sleep 1
done

echo "MariaDB is ready."

if [ ! -f wp-config.php ]; then
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
  sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
  sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
  sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
fi

echo "Starting WordPress setup..."

if ! wp core is-installed --path=/var/www/html --allow-root; then
  wp core install --url=${WP_URL} --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --path=/var/www/html --allow-root
fi

echo "Starting PHP-FPM..."

exec php-fpm83 -F
