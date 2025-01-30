if [ -f ./wordpress/wp-config.php ]
then
	echo "configure file is already exist"
else
	# download wordpress
	wget "https://wordpress.org/latest.tar.gz"
	tar -xzvf latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# reset configuratoin file
	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
	mv ./www.conf /etc/7.3/fpm/pool.d/

	# set the wordpress file
	cd /var/www/html/wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	mv wp-config-sample.php wp-config.php
fi

# waiting the mysql
# echo "Waiting MySQL to start..."
# until mysqladmin ping -h"$MYSQL_HOSTNAME" --silent; do
# sleep 2
# done

# # Ensure of the admin user
# if ! wp user list --allow-root --path=/var/www/html/wordpress | grep -q "$WP_ADMIN_USER"; then
# 	echo "Creating Wordpress Admin User..."
# 	wp user create --allow-root "$WP_ADMIN_USER" "$WP_ADMIN_EMAIL" --role=administrator --user-pass="$WP_ADMIN_PASSWORD" --path=/var/www/html/wordpress
# 	echo "Admin User created successfully"
# else
# 	echo "Admin user already exist"
# fi

exec "$@"
