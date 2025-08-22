#!/bin/sh
set -e

INIT_ARG=""

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "[init] Initialising datadir..."
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null


    cat > /tmp/init.sql <<'EOF'
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS `${MYSQL_DATABASE}` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON `${MYSQL_DATABASE}`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF


    sed -i "s/\${MYSQL_ROOT_PASSWORD}/$MYSQL_ROOT_PASSWORD/g" /tmp/init.sql
    sed -i "s/\${MYSQL_DATABASE}/$MYSQL_DATABASE/g" /tmp/init.sql
    sed -i "s/\${MYSQL_USER}/$MYSQL_USER/g" /tmp/init.sql
    sed -i "s/\${MYSQL_PASSWORD}/$MYSQL_PASSWORD/g" /tmp/init.sql

    INIT_ARG="--init-file=/tmp/init.sql"
fi

exec mysqld --user=mysql --datadir=/var/lib/mysql $INIT_ARG
