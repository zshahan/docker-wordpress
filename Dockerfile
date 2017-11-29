FROM wordpress:php7.1-fpm-alpine

RUN apk add --no-cache php-ldap
