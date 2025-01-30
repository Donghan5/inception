#!/bin/bash

service mysql start

DB_NAME="${MYSQL_DATABASE}"
DB_USER="${MYSQL_USER}"
DB_PASSWORD="${MYSQL_PASSWORD}"
ROOT_USER="root"
ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}"

mysql -u${ROOT_USER} -p${ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER '${ROOT_USER}'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

if [ -f /docker-entrypoint-initdb.d/wordpress.sql ]; then
    mysql -u${ROOT_USER} -p${ROOT_PASSWORD} ${DB_NAME} < /docker-entrypoint-initdb.d/wordpress.sql
    echo "✅ wordpress.sql import completed!"
else
    echo "⚠️ wordpress.sql do not exist. Skip."
fi

exec mysqld
