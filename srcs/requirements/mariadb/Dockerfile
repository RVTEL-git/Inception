FROM debian:bookworm-20260824

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mariadb-server \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["mariadbd", "-uroot", "test"]
