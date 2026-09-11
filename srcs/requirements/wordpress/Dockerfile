FROM debian:bookworm-20260824

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends php8.2-fpm \
	&& apt clean && rm -rf /var/lib/apt/lists/*

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

ENTRYPOINT ["php-fpm8.2",  "-FO"]
