FROM php:5.4-cli

RUN apt-get update && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install mcrypt mbstring pcntl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /data

RUN cd /data && /usr/local/bin/composer install

COPY start.sh /start.sh

RUN chown nobody:nogroup /start.sh
RUN chown -R nobody:nogroup /data

VOLUME ["/data/app/storage/sessions", "/data/db"]

USER nobody

ENTRYPOINT [ "/start.sh" ]
