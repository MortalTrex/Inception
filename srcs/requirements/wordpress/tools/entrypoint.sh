#!/bin/sh

cd /var/www/html/wordpress

if [ ! -f wp-config.php ]; then
	wp-cli.phar config create	--allow-root \
				--dbname=$DB_NAME \
				--url=https://${WP_URL} \
				--dbuser=$DB_USER \
				--dbpass=$DB_PASSWORD \
				--dbhost=$DB_HOST ;
fi

echo "if (PHP_SAPI==='cli' && !isset(\$_SERVER['HTTP_HOST'])) \$_SERVER['HTTP_HOST']='localhost';" >> wp-config.php


if ! wp-cli.phar core is-installed --allow-root; then
	wp-cli.phar core install	--allow-root \
				--url=https://${WP_URL} \
				--title=${WP_TITLE} \
				--admin_user=${WP_ADMIN_USER} \
				--admin_password=${WP_ADMIN_PASSWORD} \
				--admin_email=${WP_ADMIN_EMAIL} \
				--skip-email ;
fi
	
if ! wp-cli.phar user exists ${WP_USER} --allow-root; then
	wp-cli.phar user create		--allow-root \
				${WP_USER} ${WP_USER_EMAIL} \
				--role=author \
				--user_pass=${WP_USER_PASSWORD} ;
fi

if ! wp-cli.phar theme is-installed twentytwentyfour --allow-root; then
    wp-cli.phar theme install twentytwentyfour --allow-root
fi

if ! wp-cli.phar theme is-active twentytwentyfour --allow-root; then
	wp-cli.phar theme activate twentytwentyfour --allow-root
fi


if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

echo -e "\033[0;32mWordpress finished to set up\033[0m"
exec /usr/sbin/php-fpm83 -F -R