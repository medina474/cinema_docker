FROM postgres:17.5

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    locales; \
  sed -i '/fr_FR.UTF-8/s/^# //' /etc/locale.gen; \
  locale-gen

ENV TZ Europe/Paris
ENV LANG=fr_FR.UTF-8
ENV LANGUAGE=fr_FR:fr
ENV LC_ALL=fr_FR.UTF-8

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  postgresql-postgis

COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
COPY ./data /tmp
