# set -e

# cd /var/www/html/wordpress

# echo "Setting up WordPress configuration..."

# if [ ! -f wp-config.php ]; then
#   #cp wp-config-sample.php wp-config.php
#   sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
#   sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
#   sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
#   sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
# fi

# echo "Starting WordPress setup..."


# if ! wp-cli user get "${WP_ADMIN_USER}" --field=ID --allow-root >/dev/null 2>&1; then
#   wp-cli user create "${WP_ADMIN_USER}" "${WP_ADMIN_EMAIL}" \
#     --user_pass="${WP_ADMIN_PASSWORD}" \
#     --role=administrator \
#     --allow-root
# else
#   wp-cli user update "${WP_ADMIN_USER}" --role=administrator --allow-root
# fi


# if ! wp-cli user get "${WP_USER}" --field=ID --allow-root >/dev/null 2>&1; then
#   wp-cli user create "${WP_USER}" "${WP_USER_EMAIL}" \
#     --user_pass="${WP_USER_PASSWORD}" --role=author --allow-root
# fi

# echo "WordPress setup completed."

# exec php-fpm83 -F

#!/bin/sh

cd /var/www/html/wordpress
rm -f wp-config.php

if ! wp-cli.phar core is-installed; then
echo TEST
wp-cli.phar cli update  --yes \
						--allow-root && echo update success 1

# cat wp-config.php

wp-cli.phar config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=$WORDPRESS_DB_HOST \
					--url=https://${WP_URL}

wp-cli.phar core install	--allow-root \
			--url=https://${WP_URL} \
			--title=${WP_TITLE} \
			--admin_user=${WP_ADMIN_USER} \
			--admin_password=${WP_ADMIN_PASSWORD} \
			--admin_email=${WP_ADMIN_EMAIL};

wp-cli.phar user create		--allow-root \
			${WP_USER} ${WP_USER_EMAIL} \
			--role=author \
			--user_pass=${WP_USER_PASSWORD} ;

wp-cli.phar theme install twentytwentytwo --activate --allow-root

# ls /var/www/html/wordpress
# chown -R www-data:www-data /var/www/html/*
fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

exec /usr/sbin/php-fpm83 -F -R
