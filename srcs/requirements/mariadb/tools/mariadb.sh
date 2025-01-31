#!/bin/bash

set -e

DB_NAME="${MYSQL_DATABASE}"
DB_USER="${MYSQL_USER}"
DB_PASSWORD="${MYSQL_PASSWORD}"
ROOT_USER="root"
ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}"


echo "⏳ Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
    sleep 2
done

echo "✅ MariaDB is up and running!"


echo "🛠️ Initializing database and user..."
mysql -u${ROOT_USER} -p${ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
UPDATE mysql.user SET Password=PASSWORD('${ROOT_PASSWORD}') WHERE User='${ROOT_USER}';
FLUSH PRIVILEGES;
EOF

if [ -f /docker-entrypoint-initdb.d/wordpress.sql ]; then
    echo "📥 Importing wordpress.sql..."
    mysql -u${ROOT_USER} -p${ROOT_PASSWORD} ${DB_NAME} < /docker-entrypoint-initdb.d/wordpress.sql
    echo "✅ wordpress.sql import completed!"
else
    echo "⚠️ wordpress.sql not found. Skipping import."
fi

echo "🚀 Starting MariaDB..."
exec mysqld_safe
