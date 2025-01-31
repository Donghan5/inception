#!/bin/bash

set -e

echo "🚀 Setting up WordPress..."

if [ ! -f /var/www/html/index.php ]; then
    echo "📥 Downloading WordPress..."
    wget -q https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mv wordpress/* /var/www/html/
    rm -rf wordpress latest.tar.gz
    echo "✅ WordPress downloaded!"
fi

echo "🔧 Setting permissions..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "🚀 Starting PHP-FPM..."
exec php-fpm7.3 -F


# if [ -f ./wordpress/wp-config.php ]
# then
# 	echo "configure file is already exist"
# else
# 	# download wordpress
# 	wget "https://wordpress.org/latest.tar.gz"
# 	tar -xzvf latest.tar.gz
# 	rm -rf latest.tar.gz

# 	# reset configuratoin file
# 	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
# 	mv ./www.conf /etc/php/7.3/fpm/pool.d/

# 	# set the wordpress file
# 	cd /var/www/html/wordpress
# 	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
# 	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
# 	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
# 	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
# fi


# exec "$@"
