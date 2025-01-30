FROM debian:buster

# chown -R --> set the ownership
RUN apt-get update && apt-get -y install mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 var/run/mysqld
# open the port
EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh
ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

CMD [ "/usr/bin/mysqld", "--bind-address=0.0.0.0" ]
