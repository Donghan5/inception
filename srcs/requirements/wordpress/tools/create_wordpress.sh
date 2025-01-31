#!/bin/bash

cd /var/www/html

if [ ! -f ./wordpress/wp-config.php ]; then
    echo "Downloading WordPress..."
    wget -q "https://wordpress.org/latest.tar.gz"
    tar -xzf latest.tar.gz
    rm -f latest.tar.gz

    echo "Creating wp-config.php..."
    cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/g" ./wordpress/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/g" ./wordpress/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" ./wordpress/wp-config.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" ./wordpress/wp-config.php

    chown www-data:www-data ./wordpress/wp-config.php
    chmod 644 ./wordpress/wp-config.php
fi


exec "$@"
