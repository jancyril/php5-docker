FROM php:5.6-fpm-alpine

LABEL maintainer "Jan Cyril Segubience <jancyril@segubience.com>"

RUN apk update && apk add --no-cache ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-php5-mongo/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-php5-mongo/releases/download/1.6.14-r0/php5-mongo-1.6.14-r0.apk \
    && apk add php5-mongo-1.6.14-r0.apk \
    && docker-php-ext-install pdo_mysql \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

USER www-data
