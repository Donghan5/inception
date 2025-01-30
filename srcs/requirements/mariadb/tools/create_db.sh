# initialize mysql
mysql_install_db

# start daemon service
/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo "Data already exists"
else
# using heredoc to automize
mysql_secure_installation <<_EOF_
Y
Y
born2root1234
born2root1234
Y
n
Y
Y
_EOF_

    mysql -uroot <<EOF
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    FLUSH PRIVILEGES;
EOF

# import wordpress data
mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

# stop the daemon service
/etc/init.d/mysql stop

exec "$@"
