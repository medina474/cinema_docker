FROM postgres:17.4

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  postgresql-postgis

COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
COPY ./data /tmp
