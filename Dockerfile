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
RUN apt-get install -y php-mbstring

# install phpmyadmin
COPY srcs/phpMyAdmin-5.1.0-english.tar.gz phpMyAdmin.tar.gz
RUN tar -xzf phpMyAdmin.tar.gz && mv phpMyAdmin-*/ /usr/share/phpmyadmin && rm phpMyAdmin.tar.gz

# website files
COPY srcs/html /var/www
RUN ln -s /usr/share/phpmyadmin /var/www

# install wordpress
COPY srcs/wordpress/wordpress-5.7.1.tar.gz wordpress.tar.gz
RUN tar -xzf wordpress.tar.gz && mv wordpress /var/www/wordpress && rm wordpress.tar.gz

# setup wordpress database (set password  using --build-arg wordpress_pass=<password>; default password is "wordpress")
ARG wordpress_pass=wordpress
COPY srcs/wordpress/setup_wordpress.sh setup_wordpress.sh
RUN ./setup_wordpress.sh ${wordpress_pass} && rm setup_wordpress.sh
COPY srcs/wordpress/wp-config.php /var/www/wordpress/wp-config.php
RUN sed -i s/__DB_PASSWORD__/${wordpress_pass}/ /var/www/wordpress/wp-config.php

# store ssl certificates
COPY srcs/nginx/cert.crt /etc/nginx/ssl/cert.crt
COPY srcs/nginx/cert.key /etc/nginx/ssl/cert.key

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
