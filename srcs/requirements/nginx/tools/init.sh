#!/bin/bash

mkdir -p /etc/nginx/ssl

if [ ! /etc/nginx/ssl/inception.crt ] || [ ! /etc/nginx/ssl/inception.key ]; then
	openssl req -x509 -nodes -days 666 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=42/CN=barmarti.42.fr/UID=barmarti"

exec nginx -g "daemon off;"
