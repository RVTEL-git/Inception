FROM debian:bookworm-20260824

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mariadb-server \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY tools/init.sh /usr/local/bin/init.sh
COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/99-inception.cnf

RUN chmod +x /usr/local/bin/init.sh

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

USER mysql

ENTRYPOINT ["/usr/local/bin/init.sh"]
