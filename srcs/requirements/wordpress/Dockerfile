FROM debian:buster

# download
RUN apt-get update && apt-get -y install wget php php-fpm php-sysql curl php-cgi php-pdo \
php-gd php-cli php-mbstring && rm -rf /var/lib/apt/lists/*

# copy configuration files
COPY ./conf/www.conf /var/www/html/

RUN mkdir /run/php

# launch the sh
COPY ./tools/create_wordpress.sh /usr/local/bin/
ENTRYPOINT [ "create_wordpress.sh" ]

WORKDIR /var/www/html

# using the port 9000
EXPOSE 9000

# excute php-fpm7.3 in foreground mode
CMD [ "/usr/sbin/php-fpm7.3", "-F" ]
