FROM debian:buster

# RUN echo "deb http://deb.debian.org/debian buster-backports main" >> /etc/apt/sources.list
# install packages
RUN apt-get update
# RUN apt-get upgrade -y
RUN apt-get install -y nginx
# RUN apt-get install -y openssl
RUN apt-get install -y mariadb-server
RUN apt-get install -y php-xml
RUN apt-get install -y php-mysql
RUN apt-get install -y php-fpm
RUN apt-get install -y wget

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz && tar -xf phpMyAdmin-5.1.0-english.tar.gz && mv phpMyAdmin-*/ /usr/share/phpmyadmin && rm phpMyAdmin-5.1.0-english.tar.gz
RUN service maria-db start
RUN mysql -u root -p << "_EOF_\
CREATE DATATBASE wordpress;\
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' INDENTIFIED BY 'wordpress';\
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' INDENTIFIED BY 'wordpress';\
FLUSH PRIVILEGES;\
"
RUN wget https://wordpress.org/latest.tar.gz && tar -xf latest.tar.gz && rm latest.tar.gz

# website files
COPY srcs/html /var/www/localhost
RUN ln -s /usr/share/phpmyadmin /var/www/localhost

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

# run php-fpm and nginx
CMD /etc/entrypoint.sh
