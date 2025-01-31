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

COPY ./conf/www.conf /var/www/html/
COPY ./tools/wp-config.php /var/www/html/wp-config.php

RUN chown www-data:www-data /var/www/html/wp-config.php \
&& chmod 644 /var/www/html/wp-config.php
RUN chown -R www-data:www-data /var/www/html \
&& chmod -R 755 /var/www/html

RUN mkdir /run/php

COPY ./tools/create_wordpress.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/create_wordpress.sh" ]

WORKDIR /var/www/html/

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm7.3", "-F"]
