FROM dunglas/frankenphp

RUN install-php-extensions \
  pdo_pgsql

ADD https://raw.githubusercontent.com/mevdschee/php-crud-api/main/api.php /app/public/index.php
