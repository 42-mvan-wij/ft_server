FROM debian:buster

RUN apt-get update
# RUN apt-get upgrade -y
RUN apt-get install -y nginx
# RUN apt-get install -y openssl
# RUN apt-get install -y mariadb-server
# RUN apt-get install -y php-mysql
# RUN apt-get install -y phpmyadmin
RUN apt-get install -y php-fpm

COPY srcs/html /var/www/localhost

COPY srcs/nginx/localhost.crt /etc/nginx/ssl/localhost.crt
COPY srcs/nginx/localhost.key /etc/nginx/ssl/localhost.key

RUN rm /etc/nginx/sites-available/*
RUN rm /etc/nginx/sites-enabled/*
COPY srcs/nginx/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

EXPOSE 80
EXPOSE 443
CMD nginx -g "daemon off;"
