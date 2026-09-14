#!/bin/sh

DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
HTTPS_PORT=${HTTPS_PORT:-443}

if [ "$HTTPS_PORT" = "443" ]; then
	WP_URL="https://$DOMAIN_NAME"
else
	WP_URL="https://$DOMAIN_NAME:$HTTPS_PORT"
fi

mkdir -p /run/php
chown -R www-data:www-data /run/php

while ! mariadb-admin ping -h"mariadb" -u"$MYSQL_USER" -p"$DB_PASSWORD" >/dev/null 2>&1; do
	sleep 1
done

cd /var/www/html

if [ ! -f wp-config.php ]; then
	wp core download --allow-root
	wp config create --allow-root \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$DB_PASSWORD" \
		--dbhost="$MYSQL_HOST:3306"

	wp core install --allow-root \
		--url="$WP_URL" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email

	wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" \
		--role=author \
		--user_pass="$WP_USER_PASSWORD"

	wp option update siteurl "$WP_URL" --allow-root
	wp option update home "$WP_URL" --allow-root
fi

chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F
