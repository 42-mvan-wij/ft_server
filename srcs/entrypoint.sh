#!/bin/sh

service mysql start
php-fpm7.3 -D
nginx -g "daemon off;"
