# set -e

# cd /var/www/html/wordpress
# rm -f wp-config.php

# echo "Setting up WordPress configuration..."

# wp-cli.phar config create	--allow-root \
# 					--dbname=$MYSQL_DATABASE \
# 					--dbuser=$MYSQL_USER \
# 					--dbpass=$MYSQL_PASSWORD \
# 					--dbhost=$WORDPRESS_DB_HOST \
# 					--url=https://${WP_URL}

# wp-cli.phar core install	--allow-root \
# 			--url=https://${WP_URL} \
# 			--title=${WP_TITLE} \
# 			--admin_user=${WP_ADMIN_USER} \
# 			--admin_password=${WP_ADMIN_PASSWORD} \
# 			--admin_email=${WP_ADMIN_EMAIL};

# wp-cli.phar user create		--allow-root \
# 			${WP_USER} ${WP_USER_EMAIL} \
# 			--role=author \
# 			--user_pass=${WP_USER_PASSWORD} ;

# echo "WordPress setup completed."

# if [ ! -d /run/php ]; then
# 	mkdir /run/php;
# fi

# exec php-fpm83 -F

#!/bin/sh

cd /var/www/html/wordpress
#rm -f wp-config.php

echo ICI

# if ! wp-cli.phar core is-installed; then
wp-cli.phar cli update  --yes \
						--allow-root

# cat wp-config.php

echo CONFIG CREATE

wp-cli.phar config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=$WORDPRESS_DB_HOST \
					--url=https://${WP_URL}

echo CORE INSTALL

wp-cli.phar core install	--allow-root \
			--url=https://${WP_URL} \
			--title=${WP_TITLE} \
			--admin_user=${WP_ADMIN_USER} \
			--admin_password=${WP_ADMIN_PASSWORD} \
			--admin_email=${WP_ADMIN_EMAIL};

echo USER CREATE

wp-cli.phar user create		--allow-root \
			${WP_USER} ${WP_USER_EMAIL} \
			--role=author \
			--user_pass=${WP_USER_PASSWORD} ;

wp-cli.phar theme install twentytwentytwo --activate --allow-root

# ls /var/www/html/wordpress
# chown -R www-data:www-data /var/www/html/*
#fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

exec /usr/sbin/php-fpm83 -F -R
