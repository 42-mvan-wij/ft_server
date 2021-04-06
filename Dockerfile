FROM debian:buster

# install packages
RUN apt-get update
# RUN apt-get upgrade -y
RUN apt-get install -y nginx
# RUN apt-get install -y openssl
# RUN apt-get install -y mariadb-server
# RUN apt-get install -y php-mysql
# RUN apt-get install -y phpmyadmin
RUN apt-get install -y php-fpm

# website files
COPY srcs/html /var/www/localhost

# ssl certificates
COPY srcs/nginx/localhost.crt /etc/nginx/ssl/localhost.crt
COPY srcs/nginx/localhost.key /etc/nginx/ssl/localhost.key

# remove default nginx landing page
RUN rm /etc/nginx/sites-enabled/*

# add nginx configuration (set autoindex to "on" or "off" using --build-arg autoindex=< on | off >)
ARG autoindex=on
COPY srcs/nginx/nginx.conf /etc/nginx/sites-available/localhost
RUN sed -i s/__AUTO_INDEX__/${autoindex}/ /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

RUN mkdir -p /run/php

COPY srcs/entrypoint.sh /etc/entrypoint.sh
EXPOSE 80 443

# run nginx without a daemon to prevent the container from exiting
CMD /etc/entrypoint.sh
