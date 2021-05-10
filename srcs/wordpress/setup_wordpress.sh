#!/bin/sh

service mysql start

echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root
echo "CREATE USER 'wordpress'@'localhost';" | mysql -u root
echo "CREATE USER 'wordpress'@'%';" | mysql -u root
echo "SET PASSWORD FOR 'wordpress'@'localhost' = PASSWORD('$1');" | mysql -u root
echo "SET PASSWORD FOR 'wordpress'@'%' = PASSWORD('$1');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
