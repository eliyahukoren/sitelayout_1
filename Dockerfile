FROM php:7.4-apache

RUN a2enmod rewrite

RUN apt-get update \
    && apt-get install -y libzip-dev git wget --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install pdo mysqli pdo_mysql zip;

RUN wget https://getcomposer.org/download/2.0.9/composer.phar \
    && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

COPY docker/apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY docker/entrypoint.sh /entrypoint.sh
COPY . /var/www/html

WORKDIR /var/www/html

########################################################################################################################
# Installing composer
########################################################################################################################
# ENV COMPOSER_ALLOW_SUPERUSER 1
# ENV COMPOSER_HOME /tmp
# ENV COMPOSER_VERSION 2.0.6

# RUN curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/cb19f2aa3aeaa2006c0cd69a7ef011eb31463067/web/installer \
#     && php -r " \
#     \$signature = '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5'; \
#     \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
#     if (!hash_equals(\$signature, \$hash)) { \
#     unlink('/tmp/installer.php'); \
#     echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
#     exit(1); \
#     }" \
#     && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
#     && composer --ansi --version --no-interaction \
#     && rm -rf /tmp/* /tmp/.htaccess

# RUN chmod +x /entrypoint.sh
CMD ["apache2-foreground"]
# ENTRYPOINT ["/entrypoint.sh"]
