# to take the OS
FROM debian:buster

# to install nginx openssl and after remove cache file
RUN apt-get update && apt-get -y install nginx openssl && rm -rf /var/lib/apt/lists/*

# create SSL certificate
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/donghank.42.fr.pem -keyout /etc/ssl/donghank.42.fr.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=donghank/CN=donghank.42.fr"

# copy new configuration to nginx configuration
COPY conf/nginx.conf etc/nginx/conf.d

# Open the port (ONLY 443)
EXPOSE 443

# Excute nginx in foreground, run main process in container
CMD ["nginx", "-g", "daemon off;"]
