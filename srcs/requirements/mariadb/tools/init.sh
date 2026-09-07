#!/bin/sh

FLAG="/var/lib/mysql/.flag"
DB_DIR="/var/lib/mysql/wordpress"

rm -f /var/run/mysqld/mysqld.pid
rm -f /var/run/mysqld/mysqld.sock

mkdir -p /var/run/mysqld

chown -R mysql:mysql /var/run/mysqld /var/lib/mysql



if [ ! -f "$FLAG" ] || [ ! -f "$DB_DIR" ] ; then

	echo "Initialising mariadb"

	service mariadb start

	until mysqladmin ping > /dev/null 2>&1; do
		echo "Wait"
		sleep 2
	done

	mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" 
	mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
	mysql -u root -e "ALRTER USER 'root'@'localhost' IDENTIFIED BY '$ {MYSQL_ROOT_PASSWORD}';"
	mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
	touch "$FLAG"
	echo "Done"
else
	echo "MariaDB already instaled"
fi

exec mysqld_safe --bind-adress=0.0.0.0
