FROM php:7-fpm

ARG PUID=1000
ENV PUID=${PUID}

ARG PGID=1000
ENV PGID=${PGID}

ADD docker-php-entrypoint /usr/local/bin/docker-php-entrypoint

RUN usermod -u ${PUID} www-data && groupmod -g ${PGID} www-data
RUN mkdir -p /code && \
    curl -o /code/web_magentatv_de.php -L https://raw.githubusercontent.com/DeBaschdi/webgrabplus-siteinipack/master/siteini.pack/Germany/web_magentatv_de.php && \
    chown -R www-data:www-data /code/
