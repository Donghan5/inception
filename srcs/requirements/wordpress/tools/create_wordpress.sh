#!/bin/bash

cd /var/www/html

if [ "$$" -eq 1 ]; then
	echo "Running as PID 1. Ensuring clean start up..."
fi

if netstat -tulpn | grep -q ":9000"; then
    echo "PHP-FPM is already running. Skipping execution."
    exit 0
fi

if pgrep -x "php-fpm7.3" > dev/null; then
	echo "PHP-FPM is already running, but force stopping it first..."
	pkill -9 php-fpm7.3
fi

if [ ! -d "/run/php" ]; then
	echo "Creating /run/php directory..."
	mkdir -p /run/php
	chown -R www-data:www-data /run/php
	chmod -R 755 /run/php
fi

if [ -e "/run/php/php7.3-fpm.sock" ]; then
	echo "Removing old PHP-FPM socket file..."
	rm -rf /run/php/php7.3-fpm.sock
fi

if [ ! -f ./wordpress/wp-config.php ]; then
    echo "Downloading WordPress..."
    wget "https://wordpress.org/latest.tar.gz"
    tar -xzf latest.tar.gz
    rm -f latest.tar.gz

    echo "Creating wp-config.php..."
    cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/g" ./wordpress/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/g" ./wordpress/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" ./wordpress/wp-config.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" ./wordpress/wp-config.php

	chown -R www-data:www-data /var/www/html/wordpress
	chmod -R 755 /var/www/html/wordpress
    chown www-data:www-data ./wordpress/wp-config.php
    chmod 644 ./wordpress/wp-config.php
fi

echo "Starting PHP-FPM..."

exec /usr/sbin/php-fpm7.3 -F
