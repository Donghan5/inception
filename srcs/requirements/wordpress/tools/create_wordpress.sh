#!/bin/bash

if [ -f ./wordpress/wp-config.php ]
then
	echo "configure file is already exist"
else
	# download wordpress
	wget "https://wordpress.org/latest.tar.gz"
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

	# reset configuratoin file
	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
	mv ./www.conf /etc/php/7.3/fpm/pool.d/

	# set the wordpress file
	cd /var/www/html/wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
fi


exec "$@"
