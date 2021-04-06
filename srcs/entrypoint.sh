#!/bin/sh

php-fpm7.3 -D
nginx -g "daemon off;"
