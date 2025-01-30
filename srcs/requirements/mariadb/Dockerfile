FROM debian:buster

# chown -R --> set the ownership
RUN sudo apt-get update && sudo apt-get -y install mariadb-server mariadb-client && sudo rm -rf /var/lib/apt/lists/* && mkdir -p /var/run/mysqld \
&& chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

# open the port
EXPOSE 3306

COPY ./tools/create_db.sh /usr/local/bin/create_db.sh
COPY ./conf/wordpress.sql /usr/local/bin
RUN chmod +x /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/wordpress.sql
ENTRYPOINT [ "create_db.sh" ]

CMD [ "mysqld", "--bind-address=0.0.0.0" ]
