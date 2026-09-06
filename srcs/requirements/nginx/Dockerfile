FROM debian:bookworm-20260824

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nginx openssl \
    && rm -rf /etc/nginx/sites-enabled/default /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 666 \
		-newkey rsa:2048 \
		-out /etc/nginx/ssl/inception.crt \
		-keyout /etc/nginx/ssl/inception.key \
		-subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=42/CN=barmarti.42.fr/UID=barmarti" 

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY html/index.html /var/www/index.html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
