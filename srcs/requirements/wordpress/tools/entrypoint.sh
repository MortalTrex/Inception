#!/bin/sh
set -e

cd /var/www/html

echo "Setting up WordPress configuration..."

if [ ! -f wp-config.php ]; then
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
  sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
  sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
  sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
fi

echo "Starting WordPress setup..."


if ! wp user get "${WP_ADMIN_USER}" --field=ID --allow-root >/dev/null 2>&1; then
  wp user create "${WP_ADMIN_USER}" "${WP_ADMIN_EMAIL}" \
    --user_pass="${WP_ADMIN_PASSWORD}" \
    --role=administrator \
    --allow-root
else
  wp user update "${WP_ADMIN_USER}" --role=administrator --allow-root
fi


if ! wp user get "${WP_USER}" --field=ID --allow-root >/dev/null 2>&1; then
  wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" --role=author --allow-root
fi

echo "WordPress setup completed."

exec php-fpm83 -F
