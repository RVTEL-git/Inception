FROM debian:bookworm-20260824

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nginx openssl \
    && rm -rf /etc/nginx/sites-enabled/default /var/lib/apt/lists/*

ENTRYPOINT ["nginx", "-g", "daemon off;"]
