#!/bin/sh

cd /var/www/html/wordpress

wp-cli.phar cli update  --yes \
						--allow-root

if [ ! -f wp-config.php ]; then
	wp-cli.phar config create	--allow-root \
				--dbname=$MYSQL_DATABASE \
				--url=https://${WP_URL} \
				--dbuser=$MYSQL_USER \
				--dbpass=$MYSQL_PASSWORD \
				--dbhost=$WORDPRESS_DB_HOST ;
fi

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

echo "Wordpress is running !"
exec /usr/sbin/php-fpm83 -F -R