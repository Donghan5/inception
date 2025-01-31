FROM debian:buster

RUN apt-get update && apt-get -y install \
wget \
php \
php-cgi \
php-mysql \
php-fpm \
php-pdo \
php-gd php-cli \
php-mbstring \
&& rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/create_wordpress.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/create_wordpress.sh

RUN mkdir -p /var/www/html/wordpress \
    && chown -R www-data:www-data /var/www/html/wordpress \
    && chmod -R 755 /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html \
&& chmod -R 755 /var/www/html


RUN mkdir /run/php

COPY ./tools/create_wordpress.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/create_wordpress.sh" ]

WORKDIR /var/www/html/woredpress

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm7.3", "-F"]
